Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1528C225416
	for <bpf@vger.kernel.org>; Sat, 16 May 2026 03:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778903604; cv=none; b=dB1IvE6veKJx2bdDGDraDcVfWkBs0oaabgFFGo9jZFcSNTLF9+0Z7eCIsgDMiZMpmoJ+AjWRqxfs2hXva9jDmiLktiaclGOCZSBONeyYiGWooghF99nKk5VQtkCTkRoSN5i5yiSgu/UUX9kSc4iRH0bdPRvcuWNTH0pjjW4GrZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778903604; c=relaxed/simple;
	bh=n2ZqdUkKIBGunyb0KJlrC18xLNWLGIbDAp2kOuAgGAM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nbnj2O81DBWA96xO/lazNv9FObyvOUhlJwfbZhS7WbfW2/9a6SV0MykpLLJ3bChENUfPffXzw6aJbAjBN+zQSGuaCV6hN12oBGc51SddRfQFKMb6D4Cbz7x0KWRkr9WAc8VGKvNfvnneZtA6ygS81ogyIoazh2OZWNhHD8x8n2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpjrPWQO; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpjrPWQO"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso5496495e9.1
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 20:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778903601; x=1779508401; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2ZqdUkKIBGunyb0KJlrC18xLNWLGIbDAp2kOuAgGAM=;
        b=EpjrPWQOARxAtR3T5EB1zGbFMBv9E6hS9tgJtlucLHk2Vc+4/waeXs4D66gTd2unyZ
         L0eKQ3JVATN5RwhoPWqzVls5pfWH2g8OOJlFDeb/Yv34aL97sIC2FqyI2/Ar7+47beq+
         L+9Kh65rsRF/m89qvTGXVGWgKn17745iDquERO/kngCXs0JxJFDZPS1Jvj+Df/1i0GVv
         HSWHY6/aMZ+ZTYeiwcPU8OzeuzgkXyBVFVw78lRiWuUGVRc0cEf48192SrDZhVv0v6MF
         LwQeas5Tc+TjbeNNF5dCX/pDPWrQD4mMfTFy4sgT2wI7BjXAR1QXqh2lbLvlxB6j4ITB
         lMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778903601; x=1779508401;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n2ZqdUkKIBGunyb0KJlrC18xLNWLGIbDAp2kOuAgGAM=;
        b=WEcj36Xo5SCUNKyOOCZL6IuwltBLIFHiIDoTXSUWBzK6EakUO+TFa1GDedNFcucmz6
         F7HVHZuFx7QGMYPREx58oKAcpN9ADC24kw/pfb6A4qzLYx2LwbEIcwBOF42hFf+jzK+3
         XizAvgrkhhKt6gM3ep3oZzF75Le5kN0vNpbt3QA5rD8JJYpFQTXbz5A+VLIwj4FwQmmg
         GGQoGsFvxhvs8B7bxA8GZ+H+214Pqh5p2Y43DKUOTrUrL2MILkC95MvhfueY2LSMWehQ
         ACmkxjInc0LQ185KlrH+ppA8aqgbtQzIgqtDkkc0fHLhOqY1zp9kNlLlKwbQAndN0Rlq
         Dx9A==
X-Forwarded-Encrypted: i=1; AFNElJ82ZSZSfmsl3NQ0SMz8LwrpTPgEnKOUmoqSwRN2KmRauaZwhOwwNkXfZ17vN776Qsurn6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVDzcXeuFcIdblophPL8u552GWHSnhPn3rQK6L7XLq7VPMOv0s
	qUHiLOnv6W2Vsp26kfaLzVxF3prYqHqPhXBsHdn4rimB+Xp7L5a4ER5x
X-Gm-Gg: Acq92OH+aclXUwT82vDKm8H9ZLnEtcnyFOt/Sly3iMtTaA+UNVvsNLujLELBWd2HkWe
	it/1Ldp2c75eZSFMT1HRuP2CWGfcXWg0IuO5mKAYrtKs6EZvEtCIjjUDSSzWlQ6KXi1y/3NpYFq
	JsAT9KtaJCEn54ueXMdXKDJlxVHcNcGkeUVTd0r5oZnEABTV5hc375I2il03a3RKxTicg7+cZh1
	/8rbvEGSx6EeiKI/KICZu0vZ+8bvE430FqFZq73NDnsTX2J2wksMmVxeHWq0WGB2H35ulV4daoV
	QN18HTrueG93vlrADUDZBmT5FQ2IGT/JPNjU1/p1uiVcnh3LDDWQvENk+Q/cM3CI8xBNFEyZ6My
	6Xfcp2qu50rTO92FDwf3jgGraU++d+TndGHQAs4cjZbPOIxIG9LsXnLDAb+eSbF2bzPiH8Pai2P
	R7N7vkOhm2f5SxeUd8NHDZ48M5WbCw9PeNBWfiSuUxJdZXjbBTfI1AYCCcIwbSJXakTF+R9ndU3
	9z9jQax0jJTzZR63XYZoIOo+ivSe2ITgpXuKy0I7bX1AO3KYhUe1zIG8xRJuVqus8NM48+wYcSU
X-Received: by 2002:a05:600c:34c3:b0:48f:d0f7:78f1 with SMTP id 5b1f17b1804b1-48fe60e4e27mr97290195e9.4.1778903601223;
        Fri, 15 May 2026 20:53:21 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c88495sm102893375e9.4.2026.05.15.20.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 20:53:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 16 May 2026 05:53:20 +0200
Message-Id: <DIJSP4BF4ZW5.514DDTZYASI8@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 <kernel-team@fb.com>, "Martin KaFai Lau" <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v3 7/7] selftests/bpf: Add exception tests with
 stack arguments
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260515225035.821178-1-yonghong.song@linux.dev>
 <20260515225111.825224-1-yonghong.song@linux.dev>
In-Reply-To: <20260515225111.825224-1-yonghong.song@linux.dev>

On Sat May 16, 2026 at 12:51 AM CEST, Yonghong Song wrote:
> Add tests to verify that bpf_throw() correctly unwinds the stack
> when the program uses outgoing stack arguments (functions with >5
> args). Without the preceding fix, these tests crash the kernel
> due to corrupted callee-saved register restore.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
