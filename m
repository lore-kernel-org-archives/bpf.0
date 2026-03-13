Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0853342CBD
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 22:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773442506; cv=none; b=bFkSy+e7mHSkohy0B9dY8K/D3W33j5SScFcKgGYmQAlEFHFpYfyNg9EOSdMfMCr2G1bZqCNo7lr0jA2PXKEeDVews3M6znUe3McEZvGS6DD43GqWgwaqjhAtfv7UKv+DtmhhYaQtCcU1gu/wEY7dogIpo5j5mooKX/vqJOhANlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773442506; c=relaxed/simple;
	bh=Me2s17t4c/9F5sSKhOYWjJn1a1x+Nbns8y9ak+ENUUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAtqfu4/6YtE9hk9pvq6mFoI47nl4MYqyQN6BFs2ICEqsmfXuFBIPJx0dTHxyhrBAj2iF0wMdrYeMWiqiGgGPRoQow5XJ+LGQqDmJQpgWQfM2o5jcz9jsmls4eJK4+voGqvYXI5wT+3Jke2/s5EqZEZMsw2FgfDlg5cPZU3aUMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IyPc4IA0; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyPc4IA0"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439b9cf8cb5so2999540f8f.0
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 15:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773442503; x=1774047303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GWJfkcktUKV531/gr7gWqGhAs+DUjUg9iQZK9lKpTPk=;
        b=IyPc4IA0sl7ggpikZt64cuVUWjm/8NkqgHEnxlmogQzebIsZS/JDst/mInOkQP5nQF
         whUDGxeQ91bl43sA9kG9IfYrzx/6Wo998ewZK9CdFuFJ2gyUnkrHmf1l25QZjdmLUvGX
         4xxqjpPRTHMfPJKfKz0rK9A2lgfSK6/8f7fYqlnhgpiR5usm4li4Om3MlVawlF2b36oD
         +HFUTJScdmiPPWmpPCkVCxPmCQh06EYQcm+bpGbobG5TJsfJN16aepVBCXBKO1Xpg2He
         kj/ihNPeXpQsmGJ7xB7iDHpI3eMFGV0nCOj4CdAm5h0ozyPNJCImTQZkz/XD0SzDjjkT
         5L9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773442503; x=1774047303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWJfkcktUKV531/gr7gWqGhAs+DUjUg9iQZK9lKpTPk=;
        b=sqZCetQOvr6tGTLokQsUKMrWkPlgIMeBBSATsEajPZFYg2OFfNNclpG99WlW0YN+Z2
         qwEfbq5y7ekZ3TZ/KsjmZlnuYpZlGThUjajk+PBr9Ue7JspSarItpLYRzdhgt0IpaRtb
         kaVE9oHx68oKtqPi2dC4TYbNLVOILj3pC51KfhK7wS4FtWOlopCYEFxnrXXsjphH/NvR
         lfWoat2glvMZaQ50oWY1haZZwMwxZKrtyftNjeZvNb8UFtyIPWT/B8o0QmSf08MOXM27
         l76i32c5o361bAI7EyIl1UsTzsaXOzKKwWRFkE6bFlMR9DsIBaCCYwG6y+tmt9zA1bd9
         KO8g==
X-Gm-Message-State: AOJu0YzKAXRi+K6r5FDz3YXKROaDRFYZ+g2Yy0B1WHoaJ9dUgv9gGUNX
	K8Tt+ZQtyTqiGsYgpDLLMmQiDNaWFSEq3vnrVCslzFi9d+1cBWnSZD36janP5g==
X-Gm-Gg: ATEYQzy18wlUD+DbM1b3eF2AtKYej8ExKxaDhsjAowrPuPNHpmC1ui8sJhD7aA2g7JC
	kaIUkWAuFdFP9mZSDm6R+pv5hH7XRR/b3P0bMbrXG8kBIoNvTKclB5NcfC7YP6c8mvAhEs9oW+E
	LtiEYhNzZJ05H4x1TTXbz3AO71THIiMmNDUWaMk4kPmdDBoRx83BCmzx9wr5Ulvh4rh388RE4w2
	IC8UFPqp3DO5+Pb2dl91df9vruxCKfSp2JbB2fcgp/mVLb1Dje0TeBAdWMP+9aaPMtcMgR6mxZ4
	pvACll9eU2ZQHu21Nz41DgYnACJT0FvcYccZMTft8Xk9iqkUWfgziOaxgt7iO/Ip1kKQ+/AUWkT
	xK7jBsjpgJPNhwKIYuG4bvpY/zni2bwsjmd0q+esj7lI5427kQkykKmrZcMBNZv/JiNR1ZToF6F
	8qXCuv3VaFxANwiULhSegMsmuRB1jRCy8HedfgbGVyJ8zIbcxct+zIrX8QIC8oPu9fJKlzT1RA4
	H9FFwFZc6x60NvVhbxQCEo/EzzQdoEYCm5IqvA+0G6sL76AJU/6COuhoIeaHURFJeYxx1gOd084
	RRVdnbXyjPg=
X-Received: by 2002:a05:6000:2903:b0:439:bd70:610f with SMTP id ffacd0b85a97d-43a04dc0893mr9889149f8f.44.1773442502990;
        Fri, 13 Mar 2026 15:55:02 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e001bfc1843b6ac5345.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:1bfc:1843:b6ac:5345])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe1b287dsm20085162f8f.17.2026.03.13.15.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 15:55:02 -0700 (PDT)
Date: Fri, 13 Mar 2026 23:55:01 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next 3/4] selftests/bpf: Cover invariant violation cases
 from syzbot
Message-ID: <4233309514e3e1d70fc808daf86e28a499163280.1773441432.git.paul.chaignon@gmail.com>
References: <cover.1773441432.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1773441432.git.paul.chaignon@gmail.com>

This patch adds a selftest for the change in the previous patch. The
selftest is derived from a syzbot reproducer from [1] (among the 22
reproducers on that page, only 4 still reproduced on latest bpf tree,
all being small variants of the same invariant violation).

The test case failure without the previous patch is shown below.

  0: R1=ctx() R10=fp0
  0: (85) call bpf_get_prandom_u32#7    ; R0=scalar()
  1: (bf) r5 = r0                       ; R0=scalar(id=1) R5=scalar(id=1)
  2: (57) r5 &= -4                      ; R5=scalar(smax=0x7ffffffffffffffc,umax=0xfffffffffffffffc,smax32=0x7ffffffc,umax32=0xfffffffc,var_off=(0x0; 0xfffffffffffffffc))
  3: (bf) r7 = r0                       ; R0=scalar(id=1) R7=scalar(id=1)
  4: (57) r7 &= 1                       ; R7=scalar(smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 0x1))
  5: (07) r7 += -43                     ; R7=scalar(smin=smin32=-43,smax=smax32=-42,umin=0xffffffffffffffd5,umax=0xffffffffffffffd6,umin32=0xffffffd5,umax32=0xffffffd6,var_off=(0xffffffffffffffd4; 0x3))
  6: (5e) if w5 != w7 goto pc+1
  verifier bug: REG INVARIANTS VIOLATION (false_reg1): range bounds violation u64=[0xffffffd5, 0xffffffffffffffd4] s64=[0x80000000ffffffd5, 0x7fffffffffffffd4] u32=[0xffffffd5, 0xffffffd4] s32=[0xffffffd5, 0xffffffd4] var_off=(0xffffffd4, 0xffffffff00000000)

R5 and R7 are prepared such that their tnums intersection results in a
known constant but that constant isn't within R7's u32 bounds.
is_branch_taken isn't able to detect this case today, so the verifier
walks the impossible fallthrough branch. After regs_refine_cond_op and
reg_bounds_sync refine R5 on the assumption that the branch is taken,
the impossibility becomes apparent and results in an invariant violation
for R5: umin32 is greater than umax32.

The previous patch fixes this by using regs_refine_cond_op and
reg_bounds_sync in is_branch_taken to detect the impossible branch. The
fallthrough branch is therefore correctly detected as dead code.

Link: https://syzkaller.appspot.com/bug?extid=c950cc277150935cc0b5 [1]
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index ce09379130aa..20c857ba21a8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -2037,4 +2037,28 @@ __naked void signed_unsigned_intersection32_case2(void *ctx)
 	: __clobber_all);
 }
 
+/* Last jump can be detected as always taken because the union of R5 and R7
+ * 32bit tnums produces a constant that isn't within R7's s32 bounds.
+ */
+SEC("socket")
+__description("dead branch: tnums give impossible constant if equal")
+__success
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void tnums_equal_impossible_constant(void *ctx)
+{
+	asm volatile("										\
+	call %[bpf_get_prandom_u32];								\
+	r5 = r0;										\
+	r5 &= 0xfffffffffffffffc;	/* var_off32=(0; 0xfffffffc) */				\
+	r7 = r0;										\
+	r7 &= 0x1;			/* var_off32=(0x0; 0x1) */				\
+	r7 += -43;			/* s32=[-43; -42] & var_off32=(0xffffffd4; 0x3) */	\
+	if w5 != w7 goto +1;		/* on jump var_off32=(0xffffffd4; 0)=-44, not in s32 */	\
+	r10 = 0;										\
+	exit;											\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0

