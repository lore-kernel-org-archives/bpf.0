Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32C43FFAD0
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 04:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790139593; cv=none; b=FDyXqjywM8eyLz8pXkmKdNz0aZhsksGkUnqVo8OQyVf7cfLiwYAcs9fEKV+ToGdHin67SkIe+gNZfdpjgt4oGVh7DSHlPfyuiSzGb78ZpnjNijsCsrQydgGj3x+LHlNBjgjq+5AYKK1dlnQNpY6CHKQ/GAFgkPcwtLdQIv9rvN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790139593; c=relaxed/simple;
	bh=8qHfa7b27wCXkFnv6nCU6uD0pSSCgxl4+WxNzQH0+ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUP5gnPpjsu9cV5qQOrWhDUR/nxiogVsZJYgcHJElGhBi+olTIHugF3nB15Q5KKBQ6UAzch4281IOm7FsiHm80z00EHe/3JEH6N94UkcmJE6pI7RgknPVcoNqcxF3adVc/M+zu1Asw/V70RX012RPFy9QkuRIHjAGw8fYjcZhVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id E5D1C2C8DA7EAA; Tue, 22 Sep 2026 21:59:37 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 10/21] bpf: Refuse a private stack for a program with an exception cleanup table
Date: Tue, 22 Sep 2026 21:59:37 -0700
Message-ID: <20260923045937.2419634-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923045846.2414643-1-yonghong.song@linux.dev>
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A private stack is hard to support together with an exception cleanup
table on x86-64: a landing pad runs on the bpf_throw() walker's stack wit=
h
its frame's registers put back from a spill area, and carrying the privat=
e
stack's frame pointer through there as well would cost a register that
architecture cannot spare.

Force NO_PRIV_STACK in check_max_stack_depth(), where the choice is made,
and do it on every architecture for now rather than just x86-64. The
program still loads, but more than an optimization can be lost:
check_max_stack_depth_subprog() checks a PRIV_STACK_ADAPTIVE subprogram
against MAX_BPF_STACK on its own, and adds a NO_PRIV_STACK one to the
depth its callers have to fit in -- so a bpf2bpf chain deep enough to nee=
d
the private stack is now refused with "combined stack size of %d calls is
%d. Too large".

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7b74dd9b9f48..6462e9f2ffdc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5602,6 +5602,17 @@ static int check_max_stack_depth(struct bpf_verifi=
er_env *env)
 		}
 	}
=20
+	/*
+	 * A pad rebuilds its frame from a spill area, and on x86-64 a private
+	 * stack's frame pointer lives in r9, which no spill area holds.
+	 * Refused on every arch rather than just that one. The subprograms
+	 * below are then checked against MAX_BPF_STACK together rather than
+	 * one at a time, so this can turn a program that would have loaded
+	 * with a private stack into one that is too deep.
+	 */
+	if (env->cleanup_info_cnt)
+		priv_stack_mode =3D NO_PRIV_STACK;
+
 	if (priv_stack_mode =3D=3D PRIV_STACK_UNKNOWN)
 		priv_stack_mode =3D bpf_enable_priv_stack(env->prog);
=20
--=20
2.53.0-Meta

