Received: from mail-wr2-f8.google.com (mail-wr2-f8.google.com [74.125.225.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820F3468C04
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267527; cv=none; b=alR+X5WEZAfU35Pf8DaVB69yMeii9zXGLHaxPS9lmIQnCGJtpPoX0WdLc7ih/owErJCVtULkX3IphSKvSdWuTTIYgRca/j4tPAmi9k1LZxgl68OnrVu7lq3enizH96bDyvR4K+RSs82ONBxfCKIoGGn8y5/pLP5sUMjpdMaYFLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267527; c=relaxed/simple;
	bh=DOhWPHTOArS4mrHtJtgEtmuk6Kxe9jrINlyIz4DiUt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9dfuu0g74yhc4/9dFhhhjGXr3tt7mlHj/46n7+b2iZ6u7uhlghE4PcAOSqlWnlpv+TPQqTQTDblgRl53QpRU3uKQNfXXuD3oT9P/aEEvkNjpqi1aoj6Wcqbdzd+SUjScyTe6Y+McHIq83Fn03HegRoa0kZSR0zqQ2Im3cB8FAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8Jmutjd; arc=none smtp.client-ip=74.125.225.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8Jmutjd"
Received: by mail-wr2-f8.google.com with SMTP id ffacd0b85a97d-488795b6f69so83559f8f.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790267525; x=1790872325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3vi/tokI2txuDvIDPHNdVxf0myayiG0209UOvcPi5IU=;
        b=l8JmutjdyFbSzvoZ3kyuyRPNRwIT/3nMjH2Ps6YS1izqsI4ambTIo+2TYnpe/DthUc
         /bTs6xTIrzWluoEP+C0Ud7jrOW1fYrJGsW4AvEOFZNLXJVJjjR4+vbTKK6uJcxHaTbzS
         QX8EtrQFumYGxnm293KuPFNorACpvhXqQXpM0y2UFIrNBA4/CYOqOeD7EgU7kM7uX2kU
         oRCQXnObKdvRXu2+5qsmvc4yXpw3wI6sQu+QDfuyg5DluZu5eKtOrH0iGqj3RwWnlOC5
         JyLJDzI9NiLPx8vVPftbCKNWKF3hNVqV/ISG2XYzrKSE4MA1FS1yQzVixf5ezs/4pAae
         pDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267525; x=1790872325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3vi/tokI2txuDvIDPHNdVxf0myayiG0209UOvcPi5IU=;
        b=wrRu4GuGvMhyYZtijIpgPQ5krWX2FoepBkoJ2hOCfgVhxTJ2yg2mt9StDrmxK9iib+
         yTjJ4rwqEeKLe5lgmQi4KnDOpJBrJRec9PYP6Al+Rs1BOgKgMmyL4r8kvcFHXVNz6D8t
         CWRvBbk9pHM97FkgUX9ZpVOxw+nbik2E4gwtDXQbk3HcOwSgIeVMnquzsTEe+nFchjdN
         eHhfHNltRNPNVCFk53Likw5VhO4o3KCEtL1rYHJlSqPw45y4t/0SdOrAwxNkfmrkFy4M
         tp7g91pBPg0Roz4HkY1JvhLP/OLAwd0qMCGuJRYhFO0KyKlv8YPStCkyDjZQn/RGfEkR
         o/aA==
X-Gm-Message-State: AFuF++kkqq8U5QZp842qPF9TGHeiloxzTs6rTgB/jk7f1JJ5xGdGNAwF
	3cdKYN8OKmrTrmUq/LitkZyK8CGpZeN4354x6XqM3AVX3s6cBCxiVtH0Lcp2qXrI
X-Gm-Gg: AYBFou3yN1TO5IsYNkgSPmVL3UKjJalSeTO6GLqvgInGVGrzdQjBy96T+rKSsgdicpM
	D/CvwHiIENBCj/h161hpGiUT2bj00uQjI3mIEcLkYddiPsAaqvT6tdkGreOwDUWDq+NaE6GiXmx
	ow8tkcsii3ieAkA4U2d4XhdRzkKm9fMmUHBOtW2Pa3Clb7efkMFDrLbWByRRxcJvF8Jn1LX/eh8
	jFzyjbyFulUJE/VY83Q2rUAHpc8mgkdyH7LH1J8KqLkeJy05FAA150o0thxLihb/epVJVP6BC4N
	5xW2lFhFKmKuIknsREknbZRGTg+M3ZqyQAcP69LefcXIID+rmPJSJj1rid9p6hAuEzLTzM5TagL
	uEbv8bMMH0+FuC5nSVmN2cbn/6ffD81xU/kLzUe+l2xXNpyv1xoIQ23lf14hprKnoKO/QZOzt6h
	pNa+JBGDntaZZNqYTDoOX/oaY93+/s4fpB65+HxSgfcoHNzebAE5Rehgj6NtT3QsaNRdZgKKZLM
	pv6VTo2A+uelTSGkeM4CkVHlZtkpUI1IalvVRuta73mWQ/CLcdyP8fSxGxbNn8fK08bUU402fRQ
	yeuiRQK3h26jzrOfpUF0Kt9lpTg2kwCoq9P3qg==
X-Received: by 2002:a05:6000:26c1:b0:487:21a5:de4e with SMTP id ffacd0b85a97d-48871769a31mr5839515f8f.35.1790267524555;
        Thu, 24 Sep 2026 09:32:04 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a35fb05sm184637f8f.20.2026.09.24.09.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:32:04 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 10/18] selftests/bpf: Check that narrow stack stores define no slot
Date: Thu, 24 Sep 2026 18:31:24 +0200
Message-ID: <20260924163144.1945455-11-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924163144.1945455-1-memxor@gmail.com>
References: <20260924163144.1945455-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1719; i=memxor@gmail.com; h=from:subject; bh=DOhWPHTOArS4mrHtJtgEtmuk6Kxe9jrINlyIz4DiUt8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWur75vLNgd5zu6fx/b8Wf6h5cZBfizyx57qr17Rl3Vlb bjXsZ71HaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZiIZQrDXzHBOb4pxZr2WVph redZozZru23+I+TcLmltyCpjesboOCPDv2fPPqzb3Lv8pRO37/nfBzO82H9v/68nEzhHY4fs/o1 rOAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The stack liveness analysis records a store as a "def" only for the
4-byte half-slots it covers completely, so a one or two byte store near
the top of the frame must not define anything. Add a test that reads
fp-8, stores one byte at fp-1 and two bytes at fp-4, and reads fp-8
again, expecting no def mark on either store and the second read to
still use fp-8.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/verifier_live_stack.c | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 7a1a0670f851..f8758eb62dac 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -2839,3 +2839,25 @@ static __used __naked void imprecise_dst_spill_join_sub(void)
 	:: __imm(bpf_get_prandom_u32)
 	: __clobber_all);
 }
+
+/*
+ * A store that does not fully cover a 4-byte half-slot defines nothing, so a
+ * narrow store at the top of the frame must not turn any slot into a "def",
+ * least of all every slot of the frame: the earlier data at fp-8 stays live.
+ */
+SEC("socket")
+__log_level(2)
+__msg("0: (79) r0 = *(u64 *)(r10 -8)        ; use: fp0-8")
+__msg("1: (73) *(u8 *)(r10 -1) = r0{{$}}")
+__msg("2: (6b) *(u16 *)(r10 -4) = r0{{$}}")
+__msg("3: (79) r0 = *(u64 *)(r10 -8)        ; use: fp0-8")
+__naked void narrow_store_defines_nothing(void)
+{
+	asm volatile (
+	"r0 = *(u64 *)(r10 - 8);"
+	"*(u8 *)(r10 - 1) = r0;"
+	"*(u16 *)(r10 - 4) = r0;"
+	"r0 = *(u64 *)(r10 - 8);"
+	"exit;"
+	::: __clobber_all);
+}
-- 
2.53.0

