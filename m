Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB88243E9F3
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 20:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772138126; cv=none; b=UmEDxUjQ5y7CZ3R7KuTwK4ktmeHl7Nrz9ylsJUdvl7slfC8d0HlEKRfCq65S6JZ/BxcBBdTozfoGdcNPez+If6/k/l4+Fw2yb/bxCuAmstmB/1FzGl0tsdFGRvSI5CAplThD41OZ0O2/mAHDtZkld7d1YLlw0twcSbEiuv/34LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772138126; c=relaxed/simple;
	bh=kfZtNtlAM945/+oby8LlEWy8+TQRYJ0vCGEE8bC3kOY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bqVUq5PYBitDYfs9cQER9BYfCGaVzRjim1o4EwB+ny6/xG8VWiL9CChPE6birZhQMR7+iL2QbSwRua5rKq8BQpFkJJ5pMqEbC13wLeCaT9VUR4r0kz8pywSoWc1srGaT8VX7f0swAIUGCOWuPXnUJRQNDRINIbKDoUXQTkH1JyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=B41ixDmj; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="B41ixDmj"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-506362ac5f7so12213391cf.1
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 12:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772138124; x=1772742924; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHjqKquvIB9BrokH/ibU+Dc9tyTDZIGbnWGkcszwjdY=;
        b=B41ixDmjnfem8bEvBhhLF8ItQrnN0N7BK974fignXIIHa2l0Lf4ZluU88Vwo+uUFKM
         CsQ2ktG7uqu13ycm7jWAzluRENQAw5za6mIvuBxWDiQ7LU8ftpoZYrk7oECx5uXjEs9e
         h4wFOI6nuZK3vUKTbaE5irFApbBdpV4bBZ9rN7HXdReOrhliN2MOd2gLKvnLocbsHRME
         g/CSr7aOLILDJmf28n5vsp8qMhFtjcUjkXut95JRXb3MVsnpe6Todwx2GyhWUhkK8uN5
         hzq6dPXekG+yqU9Pha/z2gm8TMiA1J5rjGFsPnrlax1FY3sE065spw0+Y5CkHnAWIpnl
         z8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772138124; x=1772742924;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zHjqKquvIB9BrokH/ibU+Dc9tyTDZIGbnWGkcszwjdY=;
        b=JAUOPNRLN8Oa5+U9q0pkfx5ziSYx6LVYiBJsluMt63lqzXxGuQk9O6Te1WqV8Bj8uK
         0F1pZPA+WfE1w8dsWxpwX52H8wqRU2d7orEl+boPMT3KxFTBkfILTqZ20A5G8wNlIElT
         l9YoLrVnUCNr6SjyFwr7JsdU49Pc+BVczfub3Ttr6zf/SBGQn3IyGzh2aCurqOLnGNAl
         w0wy9yYRBYS3dN9P03KjmYOcTS7LootAsO2jtL7S/8oqDVQwSHBSx0k8WO+EGl13a9x5
         zDMPi3me3/2Bq76FrvU4HnYq7XO9ZOVfAKn55vIAlWOBdfBbnT0jojLLBBzXKN8uooh5
         7ffg==
X-Forwarded-Encrypted: i=1; AJvYcCUPjWaEVLQxUBKLJcCeoFnUobfdIyfsV3VRMmnTOwdDfcZ9lhgzSkpNUNvNHVGmTKR2kjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgz0GQMqL0gfOni7j/hUrSwCmTVFWW957rXGBb2V7uDy6w44M8
	Amm6JxuFnY6L0yZqvnPrWWKbdXNCm2U4JpmVCfTccSKOZ9RSnW2zvcF43n/upZYIkvk=
X-Gm-Gg: ATEYQzyk3lyZTDZp/N+psLDkaoZEyvE6EA7imkTacokntTz1QMICgbv/gl3awI449g4
	AMschPjzx0wJlO3RtbwpuvGkyQreE+MK410ctZFYWh2w94sI+rjwUdoG37CoMS0MEYqb336ECIO
	KgPuQrFyaLflx7DW+hDhBtV6WT6uiF8vR+4nl6P305cqKN41uTTvoW+N8cbU3t0ZvnP1YcBZVOf
	1Lxsl9lpPkYJEXOmT/SKhp+FdTE83So9jcyngHjE998w3W1+u53HOWf2mymDRGv4PqPgJR1LhPG
	73/3pcMF+5pz2Xj7MvW9qnG0QZUmkAao5Wryg9yKTj6fVezHGu1ClU31uMyplzAcQBeJQ/liO+w
	+Ec0r+Fq9oeAj/fogri6ATGZUGiKAFD1Chs9qcFI+6xekfCAHi7qkW4N/BZRc+maule8i59GlD1
	YZaVAktg4PfUoxCQ/Kl4pwzHA=
X-Received: by 2002:a05:622a:15ca:b0:501:3ccd:cb3e with SMTP id d75a77b69052e-507528c4f1emr3866101cf.66.1772138123576;
        Thu, 26 Feb 2026 12:35:23 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744ad885bsm26943931cf.28.2026.02.26.12.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 12:35:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Feb 2026 15:35:22 -0500
Message-Id: <DGP6JAD9617O.1TN5OOID1E4Z@etsalapatis.com>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <martin.lau@kernel.org>, <memxor@gmail.com>, <song@kernel.org>,
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 2/4] bpf: Separate bpf_throw() and
 bpf_exit() return value validation
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260225033356.518313-1-emil@etsalapatis.com>
 <20260225033356.518313-3-emil@etsalapatis.com>
 <9bbeeb42c5504ffa6de8a1a1fa02cf0432667242.camel@gmail.com>
In-Reply-To: <9bbeeb42c5504ffa6de8a1a1fa02cf0432667242.camel@gmail.com>

On Wed Feb 25, 2026 at 11:56 PM EST, Eduard Zingerman wrote:
> On Tue, 2026-02-24 at 22:33 -0500, Emil Tsalapatis wrote:
>> Both bpf_throw() and BPF_EXIT use the same return value validation
>> function, even though their validation logic is slightly different.
>> Using the same code path for both complicates the logic and makes
>> it difficult to follow, so create a new check_throw_return_code()
>> function just for bpf_throw()-based exits. Also factor code needed
>> for both functions out of check_return_code().
>>=20
>> No functional changes.
>>=20
>> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> ---
>
> I think I suggested the wrong split.
> A better border would be between checking return code for subprograms
> and for programs. Wdyt about the following branch:
> https://github.com/eddyz87/bpf/tree/check-subprogram-return-code
> (fexit_bpf2bpf/freplace_void fails,
>  but I think it could be fixed after some debugging).
>

I see, yeah this split avoids duplication and removes the constant
is_subprog checks. I'm going through the two patches rn and will=20
send out the new version with them.

> [...]

