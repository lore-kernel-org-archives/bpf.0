Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2187377EC7
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 07:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785741026; cv=pass; b=YChEUdiPUIh2ypObp1Uyjlj0cRVisWjFNRv9jIDm8GO8A+eipOVnO/Uwiuvih6Uk/BZjrtSD30PcvT3XNFEj1vpfgauIzidV/oReOL0GguhMVT41pK1mWIRJDMPek3djgmZhnAPLnAc85DPdgi15n0fNftmyyw/oxf2/AuGjxbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785741026; c=relaxed/simple;
	bh=IN9+RFN+3O/SUJs69SX/MiUVdih1zo/KnkP+fhpOh0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3Wf20aSNqudCZynYrTuUKODNqcDMMDmgw0dapKtjISqElwjk4o0JZSh4YQwTyCjcYEBr75RfI6QJVA5u4cJclNfW4Jc8Pv7F2Wa6zwiykiRo+FE0ibV9dKTiBNupgURT91Qnk9Cgm5TzZH9s52ebGfa0npU/cm5CtclJbRoLJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jf2nHlPc; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jf2nHlPc"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39c83acb86eso26816161fa.1
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 00:10:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785741022; cv=none;
        d=google.com; s=arc-20260327;
        b=NvXfabfWTI2u5yUcG08gsQ/kZ9MW0ygV9CPIkIUZdnIzo2COtkE3e4FkmeSCVcBvfV
         BqcdwtxLeBGRH6pDCm976ZY0GRB324IsxiIDLRejRjDc/V7Iv71RSm2eQ7gnAzdiKohg
         QigFYc5OTCYxx6XHpmPXcgXhdR9Z5mBUy2q2DDdt5mX8kt+HdOS+JNym60T0YraBFAqg
         7e0y3VGUWOuuGwA/crjkQH+0q14vBkLJ0H58eqMBZiIqo1QmweQk1cpd3IDOvyOZ0TOU
         tcHI6AzUV73SmwVAv9dqRPxJWF8zV8j28HuyYpjt/1Y8oWFsX0gkuFDeEI3yrdexASIx
         QcPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=173ck1uUPBZQhTije58Zju+/aVCEhgkQY5/dnDha1OQ=;
        fh=8GAb1Mb+qxtIOVEZVrf3J2AoChRw6EceRUAOI6TxVic=;
        b=ZOJ15upa/DrjTjvAbOwdhosKMJtkQRsyEbS5j3NEbmcX6SqVxJazrjWO/Tr+y5Xebt
         4kOwwm5aAdmuJXdVIp7Fm4FwnSAZyLzx3MUWwDPFJ7C+H/xNdxFS3YpQ6zuBGnGNo0qn
         4bMB0Tu2+apIaTMTjicqAu9T0PbtkdND3J6IpntCAHUeYhykhptQqTk7UoGAhKDiz5fJ
         aUsbg127QXmvJr4rVRXyZvqaEnBUPIhgexKHCZigXaehwSN65xx5D/ud9iik+oUn1GI1
         5HPXJrvcRTro9SMIQnZvjN10fxd1O3rb6M51LptLxF9scsgAz7plY2DylC6UAHRqfvaf
         4Llw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785741022; x=1786345822; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=173ck1uUPBZQhTije58Zju+/aVCEhgkQY5/dnDha1OQ=;
        b=Jf2nHlPcSPsUJ7X0JcWWkcJW7Kdgnz5cG6ryl/IvLASgPOjF4yydnUzdVF3KtrU6w/
         K6kvx1l9uskMOYkqH5xjyDZaWzl5D/aWHhXdQYQ3pFSRUN3GDO/tSXZSDKStvsTT7lZb
         WMlzIYYLCXdHSJTng/tvqhyHNrxHfmouh0h/KPEvG5BiZtnbNB2suYujz/W9HL/9BrCN
         EmezWETkLrCANdhelF/d/skq/hMl7IyYGkenfwVHsdXyBlAvxsR22LQeBBrA46KeGdkw
         L+Elq0bOC84P+/fxYaxvrTaAAaT+qDutKXqSs3Fh/vc2+lazIMr5LGixiSguaRjtGAXH
         rgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785741022; x=1786345822;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=173ck1uUPBZQhTije58Zju+/aVCEhgkQY5/dnDha1OQ=;
        b=lq4wKulJpO+mFkpA+mtP69CZzc2KNce2b8hVBLpZXMhK0jeNEGrQbgJJUwjAWJzpuf
         0Xl16hjvFVE8PiajrW6+B46q+W0sVjc+dFt/FueeDCHvoBM556bMs20WnbHKvxBFiBOj
         x2SAJb9Wo1whcIzvd+xe8JuP7muOySgAepfDjdgUhTSHrrsLlxryiC4oOLymNkl2wSe4
         NWjXj9J6D4bfwB2qQL84RcsXyCF8ohVOgWLe4JPu2bs0cl1P3lZWd1Lob1D+XiD2GLJ3
         nAxjwkZ8WiPiC6EV/VF/OtvxLZyBdvZk41gvmGtTTJeCn/xw78Boe37VgnEhRRHCbH25
         4d4A==
X-Gm-Message-State: AOJu0YyruSTL7GhOoXhzw8DrO3dcbdLmTOkmvJpbRzlwkw46i+ZHMHlE
	U0TIMQORAttotae2DXEyBV69ewhf9/eALuGLXdqqzcVx1vYpgCeltQPYbMSSXw0JzjoSn7Nl7k6
	wwJ3pEB6f4aS2fZds9lkF2PLmgp+nTxY=
X-Gm-Gg: AR+sD11hdbMQ7/8tXk58tnEquj3tXmOqZBHK/cz3X8fGzCVFE8qo56nPwjHOLZuvUaB
	YTQMQR+lrDSuqDWYQXd2K2nOm99dY1Y4UzbaCwxMHuIaRxAi0SS41wr6eo3gNkyMudRrZchxEl3
	vdZXUC73UQaPhgCBFBvDzUt9eUG4GpCMUKonDH1+zgGl9jxYwh59NAezRUqWcdjJHG02Ny8cfN/
	qgcMiopspYimn0U2449hknUFomVRoPL/TYSOfxoKxAt4RuKvFqY2l4+8WFsmlaJtpW8j8Zc8Gzd
	1i9SeGvfJioS8wVp6nL5ThA9tyxRj5W9TmvZzq2mrak/fg6ZK4WZAaii1w==
X-Received: by 2002:a05:6512:6614:b0:5ae:b998:9134 with SMTP id
 2adb3069b0e04-5b2e4f186c6mr1478623e87.1.1785741022288; Mon, 03 Aug 2026
 00:10:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726235030.1152542-1-dingning04@gmail.com>
 <20260726235030.1152542-3-dingning04@gmail.com> <DKEUKIOKSY28.2XVQVGCKLI40C@gmail.com>
 <CAJP4iuuYfqFChH1P2=3Q6WxHbMTNnAkCagR2k+Lr4W155gCj3A@mail.gmail.com>
 <DKF31NEIMOOB.2CPM6KGVXD73K@gmail.com> <CAJP4iuuz0T694PnyZmcq9f9PaQLX2kV+Sd+veQN+uydsvZ=BFA@mail.gmail.com>
 <DKF3XPW4HDQK.FDJMYDLGXZ60@gmail.com>
In-Reply-To: <DKF3XPW4HDQK.FDJMYDLGXZ60@gmail.com>
From: Ning Ding <dingning04@gmail.com>
Date: Mon, 3 Aug 2026 00:10:11 -0700
X-Gm-Features: AUfX_myRHcWSNqno7UYJybjkmO75nszFA7ZvyetPIreMn6ovUrJyAuy414V_P4w
Message-ID: <CAJP4iuskVz4RUrXKcnNhcAwMwcNjCP-Pzpc6=HqfWoDpHKWgWA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] bpf: Reject untrusted pointers in refcount_acquire
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, martin.lau@linux.dev, 
	davem@davemloft.net, greg@kroah.com
Content-Type: text/plain; charset="UTF-8"

> It will work, you can test it yourself. Reads on PTR_UNTRUSTED is fine, it gets
> handled by the BPF_PROBE_MEM loads, which handle use-after-free safely.

But if we apply the one-line change to type_is_ptr_alloc_obj(), the
read-only test I added will be rejected. SInce the read will hit that
code block and trigger the allocated object must have a referenced
id".
if (type_is_alloc(reg->type) &&
    !type_is_non_owning_ref(reg->type) &&
    !(reg->type & MEM_RCU) &&
    !reg_is_referenced(env, reg)) {
verifier_bug(env, "allocated object must have a referenced id");
return -EFAULT;
}

There are 2 possible solutions:
1. Split the type_is_ptr_alloc_obj into 2 helpers, one is only
checking whether the pointer has PTR_TO_BTF_ID | MEM_ALLOC, the other
one checks if it is also trusted:
static inline bool type_is_any_ptr_alloc_obj(u32 type)
{
return base_type(type) == PTR_TO_BTF_ID &&
       type_flag(type) & MEM_ALLOC;
}
static inline bool type_is_ptr_alloc_obj(u32 type)
{
return type_is_any_ptr_alloc_obj(type) &&
       !(type_flag(type) & PTR_UNTRUSTED);
}
reg_btf_record() will use type_is_any_ptr_alloc_obj since it only
looks up metadata, while bpf_refcount_acquire should use
type_is_ptr_alloc_obj.

3. Keep the untrusted pointer check on top like the current patch.
