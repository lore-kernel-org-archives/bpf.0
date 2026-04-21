Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561272FD7BC
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776792023; cv=none; b=RpfjJcR259BHurWiciVg9WZCDltxSzFeEMq5IJWBm54kAuZzlwpBczrm5xRvjkIhK9Wl7p6ndlPS0Gal3aBFRnNHxgTfuAEy56j6nEkf/MnckbtFLKDps0+LsrN0QU3wth6JQzQeW8rmWxia+J9SI1+U3OUnuCJlys/u7nUxjiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776792023; c=relaxed/simple;
	bh=fMeAI7T7wu0W+P7X6IcEBujh4ipY8ou4xcTlEesf8G4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gD189D3gfccvNlq5exiJ2AV9iSSTYq5ofSuqhFZGG7CHiMcfSrtNC0FWJWXjkVg9v3cf7XDU4XfzgATahvBfG2VOF+nIrQg71Ueor3DvBxGcLfF3pafc6RwhGaFITV+aZcs73nR5Pf0ygCGib3Kz5HNLxiAC/gTicckoboNlPX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 1764344B27A39; Tue, 21 Apr 2026 10:20:13 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf-next 9/9] bpf: Reuse MAX_BPF_FUNC_ARGS for maximum number of arguments
Date: Tue, 21 Apr 2026 10:20:13 -0700
Message-ID: <20260421172013.3512808-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421171927.3507554-1-yonghong.song@linux.dev>
References: <20260421171927.3507554-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently, MAX_BPF_FUNC_ARGS is used for tracepoint related progs where
the number of parameters cannot exceed MAX_BPF_FUNC_ARGS.

Here, MAX_BPF_FUNC_ARGS is reused to set a limit of the number of argumen=
ts
for bpf functions and kfunc's. The current value for MAX_BPF_FUNC_ARGS
is 12 which should be sufficient for majority of bpf functions and
kfunc's.

Acked-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3cb6b9e70080..c8e387b0ce46 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1151,6 +1151,11 @@ struct bpf_prog_offload {
=20
 /* The longest tracepoint has 12 args.
  * See include/trace/bpf_probe.h
+ *
+ * Also reuse this macro for maximum number of arguments a BPF function
+ * or a kfunc can have. Args 1-5 are passed in registers, args 6-12 via
+ * stack arg slots. The JIT may map some stack arg slots to registers ba=
sed
+ * on the native calling convention (e.g., arg 6 to R9 on x86-64).
  */
 #define MAX_BPF_FUNC_ARGS 12
=20
--=20
2.52.0

