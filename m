Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241B53AAF44
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 05:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789624663; cv=none; b=hrGWT2AzHYP7S0G4SgnkPVAxqEJDFyb00C5R7OZd88p5Y/i77H+fRgyRs1l4bVsaEY93I7VA3hMT8C2aqmS/BzzNj7McfcKlOHdCOo0OMrIB1D/j4+bWr+IkXtWBC8pUTWIL9D5SwNlEZ9oZxgZoqgpsRlE1jIk0xvBH8kQdBac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789624663; c=relaxed/simple;
	bh=OHU1k9JDJUeoqxMfACOpw6PrflUfkw/Q3iXwShXYi88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nxh/ghsW1E30euEKmvO5P/eglzV/MXKZEQP/mQl5V1weHL/Tq2YQhLXIbx8g4Gl6rCLloIDwq6AZC4rNISnkPEEWjN15wk9pzQnpbt6DNnClbFM5ygF58r+L22gYcdromeKKRwCdX4jcQ5qEiJvHofU0RpJweA6kbLJg2BUwPf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id EFECC2B4897763; Wed, 16 Sep 2026 22:57:31 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 09/20] bpf: Refuse a private stack for a program with an exception cleanup table
Date: Wed, 16 Sep 2026 22:57:31 -0700
Message-ID: <20260917055731.3931262-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917055645.3926444-1-yonghong.song@linux.dev>
References: <20260917055645.3926444-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A landing pad is about to start running outside its own frame, on the
bpf_throw() walker's stack, with that frame's registers put back from a
spill area whose contents arch_bpf_run_cleanup_pad() knows how to read. T=
he
x86-64 JIT addresses a private-stack program's frame through a scratch
register that it recomputes after each call rather than through rbp, and =
no
spill area holds that register, so a pad there would address its frame
through whatever the kernel left behind.

Refuse the combination in check_max_stack_depth(), where the choice is
made. Everywhere rather than arch-conditionally: arm64 keeps its private
stack pointer in x27, which is in the prologue spill and so survives, but=
 a
rule that holds on one arch and not the other is not worth the second cod=
e
path when nothing is lost but an optimization.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a3b34ded1392..43ecf79baa4a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5591,6 +5591,14 @@ static int check_max_stack_depth(struct bpf_verifi=
er_env *env)
 		}
 	}
=20
+	/*
+	 * A pad rebuilds its frame from a spill area, and on x86-64 a private
+	 * stack's frame pointer is in no spill area. Refused on every arch
+	 * rather than just that one.
+	 */
+	if (env->cleanup_info_cnt)
+		priv_stack_mode =3D NO_PRIV_STACK;
+
 	if (priv_stack_mode =3D=3D PRIV_STACK_UNKNOWN)
 		priv_stack_mode =3D bpf_enable_priv_stack(env->prog);
=20
--=20
2.53.0-Meta

