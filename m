Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7395938D693
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777466228; cv=none; b=RddKbm+VBjrGTrSmFfy+8U4Dup63FvwbCCFchaTYMKMjsPZRNAwv74z0pwx2gmXUE40cmN7q4ZN9a4nWf7ds1Y/OBe5Mzt8ABe8AiOTIBx9K0/I5/W1+Jk8wAWe4dmqC3GCqrvaFOaThrjlRWASl8r9MNlXk0k4xIAFjvxbvdHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777466228; c=relaxed/simple;
	bh=vM35fU1+1p+WB0TkZpS60Sn258384QiCR40B/7dPwLo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XRyb8SGRojHHekt3jsNLEsidjskEDINnXhCEGFNln7Hy5oYj16+UNQDVfFhPDIHHPWVLmPhBF23KzWiQcplzWbSB9ELEf+4pkP7ysy5VlSvVMnoQjhVHrxqMzimmw84q73XZUr/G7nTQdVCXlWMkW0UUKZJ13VKNXJAnt6FIIDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYBE8FWi; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYBE8FWi"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so90716675e9.0
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 05:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777466226; x=1778071026; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vM35fU1+1p+WB0TkZpS60Sn258384QiCR40B/7dPwLo=;
        b=KYBE8FWix0iSWF82ReqMo2V9Gh2PE1zdymkydg8a3I7HgJ1G3FOZyXrIvEu5v6hKLq
         TBMru8afbmEiKyDN7K4ZfaYMS0zpwB4g7Hh9zB7p0c5APf3wPGVHwYFJyVsJti+mRzDM
         Ab7vChqAk/2gcuESZxxdwsAp89yf1DKCqDnhCIVnGjKtl09xNurSrZJ9q96jBunFueKs
         j25FBoK/Z9sbron6r3qO4oU3VQDquVtph6i4sJujrRigz19rL7q4TCPXmnsHoSuj3Y2F
         3h1mw0eFJ8iwKhbdZOrtsR8+eY+Ne2qJtplo+lGBwpPZfUrGiUXVRV/aLwZ8P4dpEfKs
         iG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777466226; x=1778071026;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vM35fU1+1p+WB0TkZpS60Sn258384QiCR40B/7dPwLo=;
        b=gTgKC3u7VawXXMufVOajDZUKOun0/LJB9AblEQ59XJQtkL40mlqlagWsrtjIELNV/l
         TZDLo4t0lkoC2C4gBancn5s9YRHzEWBDrmofSVBHceBQGC5wcxQVZLWVKdYn71wyeoD5
         k1TROKxEdqYuUQisbBZGU6HXIYHO/AtFIoJA2YM69s/AznHukMZ7K5C2GcxvCb6SCtt/
         /5saBEKmNj732MfeyJtpPOiBh//sMvLYTfJmfsQBSlpmx+d14Vt4NIwOmEbY3Pl58Ff9
         m+MXGb5NluUmhyUYC2hpFdR3mNqY5Vgpj+Z++diWcczVYsvEUidHupcPfcWJmP/ftc6c
         g6ww==
X-Forwarded-Encrypted: i=1; AFNElJ/gj7J3/wF6fyjPNqolMM185MXxH50VGk3Sq0j53ibUWvMMeXihhVZSDe45JITK9jb1eJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf8qmpTSwdmxgb840rvkonZYz7JmWw6ubnO2QHlL3+ngplgzJw
	dWz2zrfqcsUwmo50HKID6FtQLBDGxOi38qFO665db/yaaJuAPg7uIRkK
X-Gm-Gg: AeBDieuRdzOvl6RZRKciXlyl/iXGfvGniXrtML/lD4oNvKZMWh3jCN8yhPKYCtkx9tT
	wO8wmdq0rfPgkGMRYbv7AGjy3CLSqVygMAQS+LtdVAC3UiII+PWknxyxjhfbo2ZB78aMJU1cQKF
	cLYv0rPSIeXo5AOnNiWZ57Q9oDlhVKweYFPP65A8a9+3NkE0eKghknMJ2HFR9Xo0yfmQGPJWDIb
	puMrhOXVV1WYHdbcvw4gz1O/F0QnXcXBHDXLzHO/uR655gTu8iCEtkMJqrb1jW0lBRBW9zHAPW/
	XzvBif/l7o9spLcvikMAV9Ykcf+olbj9AeOidyMtoM2nIK9bwnLa5scGh30xxq1LMZXWvXti4/A
	O6ScKV2aNOse9oyb+QXjMm0aSS9EyEYS6Z8XCx4lm75pXa9oiuPM2IFKb5LOMMn+Wt3hsn68BNI
	MOq0AZPhG5+yACFbJaStMDX0a3Y+dySIxwAx032CHBPdF6u+9wjQVnzOHTBoW/23Yw0r+yMsSJB
	K+YahhtHRPlgPDwIc0=
X-Received: by 2002:a05:600c:4593:b0:48a:599a:36fe with SMTP id 5b1f17b1804b1-48a77b1d78cmr126871595e9.24.1777466225561;
        Wed, 29 Apr 2026 05:37:05 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:1126:4:da80:667b:e928:cc8c? ([2620:10d:c092:500::7:916f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c33f51asm46930525e9.0.2026.04.29.05.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 05:37:05 -0700 (PDT)
Message-ID: <65f719480ccc5544ee2880a5eb2565848ba5cfec.camel@gmail.com>
Subject: Re: [PATCH bpf-next 06/18] bpf: Prepare architecture JIT support
 for stack arguments
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, "Jose E .
 Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,  Martin KaFai Lau
 <martin.lau@kernel.org>, Puranjay Mohan <puranjay@kernel.org>
Date: Wed, 29 Apr 2026 05:37:04 -0700
In-Reply-To: <20260424171504.2039094-1-yonghong.song@linux.dev>
References: <20260424171433.2034470-1-yonghong.song@linux.dev>
	 <20260424171504.2039094-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-24 at 10:15 -0700, Yonghong Song wrote:
> Add bpf_jit_supports_stack_args() as a weak function defaulting to
> false. Architectures that implement JIT support for stack arguments
> override it to return true.
>=20
> Reject BPF functions and kfuncs with more than 5 parameters at
> verification time if the architecture does not support stack
> arguments.
>=20
> Acked-by: Puranjay Mohan <puranjay@kernel.org>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
