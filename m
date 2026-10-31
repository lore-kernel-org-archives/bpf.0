Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793424425;
	b=3PgQpSBw8ett7LfAW4hH17l4IewOFmQpygGGiMegmKwQSQ/+AkPLNO8A3byUs4RgFBOV
	 Ivw2D96yI7y94P9QC6TwNjy25e7kJilCLqWx/L1kWH7sgiuV9faDhxuzNiW4/TwoteN9y
	 lo1Kp677VQBDyvLCQ17AXE5n0lk/0Uop4oG0cV8qre/vpWDOHbh9F1bJXhc09Io431ARj
	 7j46nVymPNCpUFf7UJd3qQvyedUDWK11UQIjTkPCTXGxmdcmxu2r8S+YvDEghA41KpHcO
	 uyd+HdQ+BC+iOzVf9VIw9M6CpkJhIIqrKFSUM8reGGZ187lL7esnOUkrpejiViJ04YA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793424425;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=VOuCTlvKWJ+Ik+6X7ClGWB5L69gn29siaospeRViXc8=;
	b=aaRGkotzFjSoPu/HoL0OdafScw+xYXG72P4dC0hl/85NC96juu/+OiKLsaXOl8X98dJm
	 fQTwvyVq9cPe0pWWdosdW+KLJm0AOpqAvzMfLlnypeZH7aMLvGhF9iYyitgzm/DT/vJyt
	 KtiIf7tirL6wPr4NLSzwCG6MjVMu1+7JKIn1VXtSgIRvAMvxyoD2QNxLkvSlcvpAdL15g
	 E0TgbxGbW/uyGGNij0PX6hP7SU7kJsIV4RCixLzlkVatq+ek0+n8ObQ02kUxV+HbnmaVa
	 38b05GtADnSjQngwgVxIfvBIQfvwWOQMDXRfFpUIb5eyTO42V2nBWEF/iU83LHntBLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="l/p6575z";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510AF606A31A
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 05:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 510AF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l/p6575z
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e812e2b31bso8477565ad.3
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 22:27:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793424425; cv=none;
        d=google.com; s=arc-20260327;
        b=r+jxoR4f+YxQAxweAXUvsQ4ZETsSbzIuWHltIXr+boBkuX2smbKlOaknLCs8daUYdq
         vUuIDCC5EXV50E26QP5MB61Ip1V3LIRKrlpknGrZkGSLI1i7IOlhUzNatM4rinn/ZEqI
         TOOn0dz4Nd7wFuJtAs5cHqBb1zTF/UiHscktutkzmuE9ylzFM+roAddM9OBiw5QomtiS
         f+FIV0WQDOvbzVI4/00N+UvBGFPig8FB7nTWebKro94ejT8nn1dSgEyGLT4z15FBttEG
         cS2O6CUtt03NrkJiffEVbGK6efXoefKvmWJ4GIJJ4HriAdF+13uPdesw6uZWuwCW81Cj
         zaGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VOuCTlvKWJ+Ik+6X7ClGWB5L69gn29siaospeRViXc8=;
        fh=ndG8SGlk1DK7JLpFV1mzpjjvgqxxS3XNr1vCbYFbih0=;
        b=GDxAfsQKR1mp1tBiuXJDrXAjE6uvpBa4QAz82IqXFFEUHOOvfogDH3ccOpZSq7VHYU
         V0d/NdjXFtCUsxVgTPIZbR90X4tXvtQ4tL+RQiyKhujdFR1Vr4VPRnxNmaAZ0lokbeU/
         SEBKtKsWB9CNm1ik3vHpJyp3aYLs4oZ+Hra3roftWNhN3SWUY/05f95jj+5E+mEM2M43
         DttZUO4CMuFjjALhKKos3u8NSJXNIzvE2gmnN1jIqDaQreP2Zejb0UNx3DBMng0uTjvt
         hJlMwj4b6oB0GL93vzEJPhHT/Nsq57HVcwLiurYtAt0uU+9IGn0zRSQTe0ZrKJz/LEC/
         PQMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793424425; x=1794029225; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VOuCTlvKWJ+Ik+6X7ClGWB5L69gn29siaospeRViXc8=;
        b=l/p6575z5MEMcLFdtgRlW1tbmjF1IS/ig62Ku8G0G8J6P8isnUlkvVPwo/FlOeazTZ
         hNsgIN5t6FwlSMU8gZQZzTexGouJdyxkDjyjZiRiN69YWWizu+8XqaUT7uH68m993Ozo
         xHXgoh+QN4cG39Srs5XTl6FD06yyKwt7v6QRR5HO+NetGsCryOIlwUQAJAdsG7ycR9rl
         X+JidiI3pG4qpQIMxu2O8s6Eozf6m9hIlsUeHF0U5gEzxbPX1q8bGa/ZXJxEyefq44Je
         wC3HfeBY8XLs5sn8nYXjOG/8uX6g3+B2Ifj3iO6v68g5OLWfaEH7Q0KKItec/+L219mE
         9+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793424425; x=1794029225;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VOuCTlvKWJ+Ik+6X7ClGWB5L69gn29siaospeRViXc8=;
        b=M256AKMC0ylJrmZB+j8fiQDVhlPstTTZdvPKSKnSgioEAN43D7T6KWFVDgePESrMNC
         b6fhV9dqj1OargTGphxQuj/ZCxurGWwDjXhT267zOVYZtio+9AOjK78OCVVGwhOmsDM1
         i4lq6p4mJdY6M2Fy3oIZFnfp0tn31Pr2sdv8kas/OHnGziC3QRQ0WQLQHo8W4zJWjIit
         i9nHNs3xotz86m5rZg0MDghQsA7Om9BYYEBM6FOviGYQ4dDIWaF34Y+k5R30GHxwvwZk
         YpOa/6NpVBlhIh+cnu66GxyCeaMNNICsBGwN0Tt40U/6JOKIZQh23h8r5CepZF1AOfrp
         KVFw==
X-Gm-Message-State: AFq9FYKWjFnLbuRw5anlA6SGaaLENW057a7+MrCH0rKewwk03M8erp5B
	h8QzbDg0PLCgXM8sJsrTYFTkICOVlO6hHyYqs98hCQWwRMSTLYFUDHNArGhPO87MeE1pEg/WkeS
	TuYpr2mqux1xjMmt8OjLPmdrnRyuuBFM=
X-Gm-Gg: AYBFou0O5AiSQV4IOk8dhuAUcWOLw0UOQ6SxMq5TqSQDarCwSaLtyt/Oc8JzptONA/q
	w//UGXt16ETTBHzbxE6nav2tVgFXacWEh84Kfskn2rkfEDefcupgy/Wd77ZDicHXg7ij4Uqu4xe
	LlEhNWMyP+AlOKJZ7R3YPKLOvn+Hxui84SGnQwC9bNds9naXTKaaY1VvrfUqdwb1X5/Sip3M91l
	ibkTkPBuUwvmy9ZMQKLGSEFrd6jZGzZmzDP6OmDBmiAWXdC2SPoQNdEj22dcK7VHEevm9R9qmzT
	nJKO3E+gnONTEjj5ctpHmYiIXpptalSVQY48Znc6njH3GEr6X4kYZBSH30fu0KJthNd+hXWMDVs
	dapx8tT7hJlCg92v7s9hUmukOCAb0YRKWv4lDtTp6rXmWKG0/CYuq5r/le7ZG+2FKV3oGVfu+Sy
	fPbcST22CAy5cD60z4F/I8czondAWScLE0IhlYNlk/R6lUP3+SwDTk7cg=
X-Received: by 2002:a17:902:f54a:b0:2e4:adb3:c776 with SMTP id
 d9443c01a7336-2eb364b8234mr43942695ad.24.1793424424484; Fri, 30 Oct 2026
 22:27:04 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAJgm7qNx6NBzfxQbwF0ZoMLoULquNpsnrYSL1F3EFf2tztES7Q@mail.gmail.com>
 <2026103022-epilogue-coeditor-0029@gregkh> <CAJgm7qMWGF3zWOR=5qO8RWmufGud6fcNBQQxTsVgx=CgvRz3Qg@mail.gmail.com>
In-Reply-To: <CAJgm7qMWGF3zWOR=5qO8RWmufGud6fcNBQQxTsVgx=CgvRz3Qg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 30 Oct 2026 22:26:52 -0700
X-Gm-Features: AclHuK8QLRDbunwR7GWG0EiiYWANxSeZdFxrArQJ6MnaONc5mCqXQxHgShu0hJE
Message-ID: <CAADnVQ+spWODbcC25SwVFXUv+ksPNuVkQgxtq4PwLHdDDsSZCA@mail.gmail.com>
Subject: Re: gotox/INSN_ARRAY cross-subprog fixes: request vuln-fix
 designation and stable tags
To: James Burton <jamesburton@meta.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard <eddyz87@gmail.com>, Anton Protopopov <a.s.protopopov@gmail.com>, 
	Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 6:11=E2=80=AFPM James Burton <jamesburton@meta.com>=
 wrote:
>
> Their view is that CAP_BPF holders are outside the threat model unless
> a boundary is
> documented.

James,
I'm sure your tokens can be used for a better good.
Please search lore before your next "I need CVE for this AI slop" patch.
