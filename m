Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F9B3D6CD9
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 05:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882996; cv=none; b=tdkWOWF0xDH/H4waK5j+qGwQfn/oo1rza/SEgap1DmNJDs6AzQqXPw1fyhdsqQvVkXPrQcJBtCyS2W3qdEwxVHP5hDzFYvdJUZ6yvLCRXTMBQFNlKckzR1QY3WvqFpqEjE0T9Lmxl6hGn6vGWeQDwvayXbJNNE7OH5t170nvASI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882996; c=relaxed/simple;
	bh=c0jAYZ+qv7imkW50vdfJB5DWjRHOgBkMMGjGF04N9Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPMAGpVWU5XlWFgGk1EnUpjbE+gT66Ez/AUmXIT3H9SslnosqZkADtdVZ9G7iJ11YxFzpykqCDA9j6XCrBJm65vxJ0Xn/28H12M9nLOwbhEMeaVLvzTo6hzfRkTFjJUYxpXGUWjpBGkNgvInYPx2RlrgaG6rD/0s7jkeeKnSCy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 2D4FB2BEBAB718; Sat, 19 Sep 2026 22:43:12 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 09/20] bpf: Refuse a private stack for a program with an exception cleanup table
Date: Sat, 19 Sep 2026 22:43:12 -0700
Message-ID: <20260920054312.869165-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920054225.864535-1-yonghong.song@linux.dev>
References: <20260920054225.864535-1-yonghong.song@linux.dev>
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

Refuse the combination in check_max_stack_depth(), where the choice is
made, and refuse it on every architecture for now rather than just x86-64=
.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6ca242d70a4c..b978e710d7b6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5592,6 +5592,14 @@ static int check_max_stack_depth(struct bpf_verifi=
er_env *env)
 		}
 	}
=20
+	/*
+	 * A pad rebuilds its frame from a spill area, and on x86-64 a private
+	 * stack's frame pointer lives in r9, which no spill area holds.
+	 * Refused on every arch rather than just that one.
+	 */
+	if (env->cleanup_info_cnt)
+		priv_stack_mode =3D NO_PRIV_STACK;
+
 	if (priv_stack_mode =3D=3D PRIV_STACK_UNKNOWN)
 		priv_stack_mode =3D bpf_enable_priv_stack(env->prog);
=20
--=20
2.53.0-Meta

