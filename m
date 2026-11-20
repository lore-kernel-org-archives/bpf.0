Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207328;
	b=3sUnvUV3lAPObDwls2rsIFacuUI61bKcuslAKkx7NDGF9Gj94sxk3Vd+f2BOrdXh0i3D
	 PWTKLsVQp+wyRhSgZ8UU0mdLJGbi6+0eyGfVDhzCnukIzwaYUtAocg50OZKpISpRs4F4k
	 3EU0Y28TOKrc0rZFRgAYNWR7gXJ6deioRNA9GJ65ay+HUv+vpS8H/dhsBSWXT9GJthvrG
	 naK4XffTNcwZ9rbDQhVIdrGAISWryqegKMuYu/SdODNyTVEq/aYtGbp9pDbA9V1f+OAJT
	 04Nk4VAJsAqaih8XdcPGS0HDBHUqJBBbPxcbKRbubEMEGC5/vq8ltUvO5gJE70eUMSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207328;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding;
	bh=KrVV3AOCGOoPGe2MUIFLejrxfFKgPLjyVQ0ZWShESYk=;
	b=bSD46xHcRCylEdmQcV48XFw0uRoRqZcCvvTAM0++cQyQaWMray/U78mew9veNLnEDbe3
	 j4wJeEISPs6lyJvkNU/vXavGlM/ukAdN7WOmAMXmXrZ4O/OtAzIkKPY1hJHatbyp2BQ4W
	 EZi2fhHOCS+T4NUUNSbzCb/492kigD1v1OIpHPQbi8+gxCRAHkTWZxZOJl1JSlYs6HXJs
	 SMmsmNY+T0/RHOOF9JT32btU78eR/c1t2fxfhw/BhHFf9sv6AgXxGt7KA8VVElPo4iBet
	 kpKuczKdnBtt7dAZnxLaedJji5aKBq39d8TKInDPDminLcn3ZcuxjFdDmAoEqT+Y1HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BE1606A6D4
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5BE1606A6D4
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9496317b730so161086985a.1
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:42:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207326; x=1795812126;
        h=content-transfer-encoding:content-type:references:in-reply-to
         :mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KrVV3AOCGOoPGe2MUIFLejrxfFKgPLjyVQ0ZWShESYk=;
        b=IMPghaz4XCZ/HVvNy2BRTTe6/tB7SC9et/cYHlPrm9x7iuoYyHFYi5E7sZ8h82R7PJ
         v4UyUKe5jBlfUgtlcGY56BKZ1++0H+8/T/O1Pw21933NaqSHpjvI/VOYd5xboVubwhrb
         S9xLSHoXx5XYTKW9BXJUm9Or9cwevysjGV0gKjtcxLLZrEFTj7WVkIBxepM9im2VXMAa
         Yu7ZVNnX2nyohL2mT8J3lajuDXiJkerJFV5s+9sCUe75p+lbJQJvKLCoLgPd8UiVdlSh
         +NGbJw4BxxtLex+WwsRfS3wMwIkLORWT98aRR4Vn1rFoVU/HVtsS0A4cx420rOPA0kwJ
         V82w==
X-Gm-Message-State: APuU4Z8D3bptfr1IZjs+ay5TMijqDTd0COfOCcYxD5i8X6G4rqKnRIdi
	crYp3Nj8wYTMMjc4O5LVwbQBWPYRCuV4PyyBVPTKE977FWkBOaMTsl2rbaVbAg==
X-Gm-Gg: AYBFou33FN3zC1mvbuDOeuPC/WC27JCuLZB7cL1j8ZDkqcM0tLMjpeB5NEQ3EGgjdl8
	Qplz2614KL5YSmXJqvTYfhi2pDhU3Kf0Pa6L9U1RzQ6mTHUbch93Mdidc3Ql5T+4kRwTk5WUIvd
	/+p2WGp/ZINbxF2IMD4/6TiEnKGU3xJKMzs8w/aHbohunCyXTgDW6Mg1HtsYxYrAXMrS9FAu109
	2TmwE9ExrfLYAOpiOhhUcplVta5Ko2fVlEtziWMsMOAV+TpZ+4OJnfOY91kaRXvU0vmEpWi1hKx
	/Rklnz6e3KYtetKDn1F7NC6e0D4lbyvU5Gy+4/rrmlYje5icTTJfXzSFFK65DazNk274qxmeusZ
	87cKdq2MCB9SZ0h+HPiLfLRsQa9dN57Z8pR0URxo8atZlOz1UKFCkW/xYKdHyg5lRJTHzF55dTK
	Wql7hUo3xPy7Tjwpm8guN2uorSGsQ+RBSEL+JLQQ35A+H0GyvbS5fWnhMB3daCwgREzylXiKsAK
	BLv8AEzJ8y+0I6Uzf3kr50s5d8QoisAM4u6UV5cx0NZ7bXHWf5PU9MC2TZZN2QynhpLJBJ03xRs
	iqsDAxnsxKoF1Uybi7av/cQ0n43UiPG+jarzdH7moQbm+/56mgL4R9c5R6WL+hwrbEm/C06rwag
	gn3YbJ4flFs06FzZoXxMZbBFg4h6GQW3dlmnN6CPLuHGI1BjphAYwwdAc0gLVw7QmdKtQAlx4Hw
	==
X-Received: by 2002:a05:620a:1711:b0:949:7759:7fb4 with SMTP id af79cd13be357-949ba9e258bmr714400685a.39.1795207326583;
        Fri, 20 Nov 2026 12:42:06 -0800 (PST)
Received: from localhost ([199.170.132.196])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb3f1ee7sm273793285a.28.2026.11.20.12.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:42:06 -0800 (PST)
From: Tamir Duberstein <tamird@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf 3/6] libbpf: ringbuf: Handle position counter wrap
Date: Fri, 20 Nov 2026 17:51:54 -0000
Message-ID: <179519711421.18576.2781507926971358718@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20260614020552.022A11F000E9@smtp.kernel.org>
References: <20260613-bpf-ringbuf-fixes-v1-3-e623481cb724@kernel.org> <20260614020552.022A11F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> does the kernel side have a similar
> wrap-around issue in __bpf_ringbuf_reserve()?

Yes. Fixed independently by 6ff5b56a50c5, now in the base.

> [...]

> does __bpf_user_ringbuf_peek() have
> a related wrap-around bug on 32-bit systems?

Yes. Fixed in v3 using native-width subtraction and span validation.
The mixed-width ABI issue remains separate.
