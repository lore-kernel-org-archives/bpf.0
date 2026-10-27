Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118740;
	b=OLgB4sbPArsw0jsNFFIqYgiHw1nhIrEFwbX5z100EFPLJBSfNvMJ7ovVcHNWFuMO4F1W
	 GgGWS6FneVe+vmfZEa6pj9tXtpB/kQFl428NJIE+6A0tHv8GDhRZNa6WAGp5aQ/jBNErx
	 DDxW3aL0GtljvGWKVBf2KQfsmfi7aW9oUlI2TYJ3VErRc2TU8uCgBaU1YpHmZhiFh+CU0
	 iwqmErTHMGUj/QE5o2aYk/rn6RJU/ljf4aOUuim72kdmwDMLApdwmE6aQIiPUDy/do3Rj
	 UpFzdQh2hFzwAxoycDQgKbWPK1bmrfdk4QGiUUzpaAh34ojF9HP+ic4IO3sOh34FVAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118740;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=0mdL64Frw2gub/zA/rrwkHIJcZJCaoWtWai8A7v56Kc=;
	b=Cz9cqPpF6Y6BEVL7cbkA4SPpYdkBFunqf1Xl97+1eq5V8CIc+txzrD0tvoqjcHsqHR8q
	 itcs5StwhUsqhodZ0ejLElQNbluPec1PjYys6kqXJtnxne8vu59Bd0OBHV58JtbODIqF2
	 1eLKwQNxRJS9G1EmJ5/dKCoseVqP9oPe7wCByV9VUpK+xe9qwSNQSTE+t/l8RmiqOUd4o
	 DAFhsOTC4pMC1dLKh1wyGY+7NQtjZ/MEv0khhCEAUIFA+h2DcRtDUsXhYabjImWaNlxXz
	 FsvuRfwvW6DjLVntjy0f4ZCoHovL2CAxH0smq5+8irBpEVkgEaAGJMf72hWzw26IsCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ba88qj7K;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E52606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 16:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48E52606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ba88qj7K
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e985106c0cso37344055ad.2
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 09:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793118740; x=1793723540; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0mdL64Frw2gub/zA/rrwkHIJcZJCaoWtWai8A7v56Kc=;
        b=Ba88qj7K4evVzQpwU4BZMvR0OyAO80pmVJevTUId/DUPyfmmnL006JSHRZh30genZs
         wXu3oeYEDskhwTfrwMUl9Yxd3eW9vd5Lq+3z2vv1caqz1pYmzxmJyAcW7FcbrHDuUe51
         4J05BdUhItOXsNLTVaG+X9WuJhb4j8tW0zEuj7T1W1DDjhOAxNTyC/4kEukK46j+c9X1
         +d4BAT8UfsRWHom4i3geEu1GqgtCTfg6rhKG6mBCMqoesnONm1a1hmpT81jFoTAmnbS9
         xgdIKtH64xx+SYmQ4G3V2LCuc/4cntH4VTms0cWw8gwkzlHeAgQYF+XUvoCsOEsyHpIo
         C1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793118740; x=1793723540;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0mdL64Frw2gub/zA/rrwkHIJcZJCaoWtWai8A7v56Kc=;
        b=LakMYSvtsXzhU9yNJYs3CdZUIfTy8g/4sZNL3huAE8W/Bj4JR5FMW9BaROH+vIfP9X
         CD0cN4jWp+HbIofaFXaZe+gazwn9c++epnNBQVWZ+NeYt/o7i8jPGn1FccGdC8m9e8GM
         +XM6kJShhhLC7VD2sPJX4y450BOIr6UNTJN8/Wd9JmqWe32hgYbv9J5akQyPOyLMhgx9
         In7LU/gzLtzxsUjx1rrSaLKoOdk86o6z/unRyfgv3P4B1h+eZAKETeCmVj8bJCa+Xb8V
         fSK2DtRtmPmS3pcrPk9AsIf5W8l1+UO9GrLV3QqXMOVf3dR/drczocCy7smTtULkjpek
         y3/w==
X-Forwarded-Encrypted: i=1; AKwUvBxdDjxLT9XpUB0+Pa+tiDEPsr8zktjXE6SL8EPPb33MGSr4dMUQLkkm9aG06zUtwTlq0gs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIqbfwfTPPfjtk4TXOwgN2A+IzCia0rEUwgy4eDucGWbVXHks9T
	zRMKxc780BdDxO8sRD4VdZbIeskYTDr2LME2N6nQMR5KapEn+8cB1TNd
X-Gm-Gg: AYBFou3uoDprPmTQA/OXW8z0y/5Ztu3bpfK/CUHt5PdorxfwsUGoegJKUdHDbbC8iyT
	Y8AquHAjIMPDRONkgAVvxf5mpg6RiquW3qp9nHyoAx0xlFTvJsixQC8E1Y1gN5Eju7+rTDEUJym
	zyY9IkbsBOZiF5hjrsQYImjbsGT+EzSJ9Tgso2Z9nPLxN3pOBsfpnMKdLnDbYXOkWEQKOMgallN
	vlCAeLGhOOY91n2gytIdyBR69wId0L2y+GAuNwRWpSobXGFgsHW+jph77Sb9vdINiVi0iPFHsgm
	78bBtco9ahkPq5hieFyX4LFfK2BhuXBxh86v/WIaCdkvYDtl7Ssoj/nzC0edbQ8WnBQLKP1GESY
	yJjkvfgygr2Pb1oEHAYJP7wcUuEOSYoxcguPIlrvh3Ppvk98hJiZBAyuhqqUmO5umRuQ9ExVT1P
	UcJTahcBYLhXwVMowm8ZBf5mbLlDfTXh1g6FW+6B2xKsh8xvboAaDuRb38mf9/I5IrE4oNhyUoH
	+A8M0iSaRDro37L9RgEN/ZYPtAu+8zh48hgmSO49mkOc8iA/fzS8utlvX7D4Ae3tra+2GykGS50
	hHnXe5OXiOYQUpJggJd48dUrukBKMDUvqoxwoEH6JIIRGRgV4JD2+mPtRIdw
X-Received: by 2002:a17:903:1206:b0:2d7:107c:917b with SMTP id d9443c01a7336-2ea9b8c3f02mr91246485ad.0.1793118739516;
        Tue, 27 Oct 2026 09:32:19 -0700 (PDT)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9d2cesm12356595ad.65.2026.10.27.09.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 09:32:18 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Oct 2026 16:32:18 +0000
Message-Id: <DMFRJKE5O9OE.3CSUZC83JX864@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <memxor@gmail.com>
Subject: Re: [PATCH bpf 14/81] bpf: Fix a false verifier bug in the clamp of
 scalar evolution
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <5e87915b1065db0c4ce8f7f4368a8c3109cfe891.camel@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com> <20261026025943.404450-15-alexei.starovoitov@gmail.com> <5e87915b1065db0c4ce8f7f4368a8c3109cfe891.camel@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Oct 26, 2026 at 04:45 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>> +		if (!bpf_reg_range_is_empty(r64, r32, bounds.base, bounds.step)) {
>> +			bounds.r64 = r64;
>> +			bounds.r32 = r32;
>>  		}
>
> I'd suggest addressing this as in [1,2]. I'd expect that selective
> clamping would be a subject to counter-examples as well, just a bit
> more convoluted.

fine. applied yours and rebase on top.
