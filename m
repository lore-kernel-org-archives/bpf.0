Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F06426A0B9
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 20:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785702067; cv=none; b=JfCopw8koXwltt2bebVE0uwDpZjFYHozmKFoUH7S7K1VAF9rxfnqg+orF9u7U64T/QmrGwGcBefV54VVVRZDC5rSgSwce8V4Q3VazFrIPVRAj0pkB1J9zouiCfiDrdvNAHcTVaX1TjTNftjtWOE88iH9ztFavt0l3XzMqd95eGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785702067; c=relaxed/simple;
	bh=25YexXeXitb17ga4HG2cR9kvtu8K5w4d6g2q3n//Zis=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V9TPFR1WLLahPvkn60AtV/mejhsSWtye07cas/lZyyIblQUt3c+zSLgWiDjP80d4F5jJMHc7CcHEIUPjsuuz6N7fh3xLwFCuL0wyiOzuRldRZR5FDZNIqOeWIJQjmKKcdQvDJLTZqo4jL7XJ/V/A9sixF4n88njw4Od9a2w6OSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTHaIeIY; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTHaIeIY"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8487088510aso2747342b3a.0
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 13:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785702066; x=1786306866; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=25YexXeXitb17ga4HG2cR9kvtu8K5w4d6g2q3n//Zis=;
        b=bTHaIeIYYcR21wcYJO0EFuvQei0G2VcZ8OLlm2NWQRl7IwbiOFjsPn5WBfPDAcv9oK
         vow8DPf5imDkVvRL8pRmg+4trRrgtYpPlP6G8+xz62tOo3Fg5cPc0XgyrrmTqX9WD1N/
         NIki2ObzOzN9yhG4V4MvN5q/nHH6UudPlGSv44Y8VXvSRFFu9Ax+iNPZb2WcCn0ZBhxI
         w9uqx1uuaqmWcYcbtEwv0I8MJiSx56PhCw8FlCyGJlOFhGG5sfDMEQnvsk0Iw0dqvwt7
         vkXDwGmiWq0s4WuwXBN8Y2kXz9u6ZokDJ7eA+xjTW35fLr/9hTfXwDinXvG9pl/6LfZ+
         G+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785702066; x=1786306866;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=25YexXeXitb17ga4HG2cR9kvtu8K5w4d6g2q3n//Zis=;
        b=me5rZwtgkjZRIl9xLGBLhoWdxu0zbHM6nQKCdurb0MR1DfzrFOOksU0NeoE0d3dkpJ
         D2x/q0LQe8/QSG6z9SU+MfTsRGRfMXoZJ2GfSl+5lFcD8e8aTz8MuyQfZ9NoolDMQbzf
         B/glCxLKIpJDCpZvMuKm+wH+5qzAQgW/nINFl5Zvc7pnWsUi/HrjG2IbWpZWt0VNcG6D
         IKf45wj1HiMMkZ43of/y20t+K3lMoh2mUzVJCz3UGxLU+ndAYrKG3TxYJtZt9ZHdZuO7
         uSAiErWZosWg+qgP9/+eYeX/VEPJtYSgQl2VXaqKo5SLcBi6bT5EsoRWhDLYXC3IFrYR
         4z0w==
X-Gm-Message-State: AOJu0YyTYn+z9Llpkr9wzvO0JwuittvShYoy3r9qbzhOzlqu21UJboSd
	xZSiLjXsLL6Dx2lySQ+1aWPQbwxkhi2Mx4Szcfk4I3EdQOTBzIlTWh9A
X-Gm-Gg: AR+sD10spQkyvtMc0mgbXpDHj4StWLci5uiGQ63EvRa2/0oWryqHxj581hFxtLwzZ3T
	RODgCG8dyPUQ0G5InXRErRkV3j9aKer3syFhsz7v5CNyQfI4SjMJfaPHket4rXVBKlbOC8cSCQp
	d5rRIA1/8hXaKxBZABOG+ARUygyd4YI1ERUlLkOCB8NQqaJqCrKlLXHStA7RSQp0c/hTnrgvvpv
	tKLNZjB56lLvEXQFd5bLLHS8GFW6auyp2wW0MKBo9Zls7cDe4m/BADGpfMOH9UwiihF0J1VU4oN
	pDs3h3+jNO9dOoar5XZHU+Ooi81GAXQtRTgMO6Mc3NWuxw+kQF4M/CdsvimqQwXZwJ0kMxpMPTi
	9VSLE2hmAo7/BniiXFXWDdn7k+C4JQVBZDbz5kciiMZBd1E54TGZomlfR31wUAnAGRObMSQiVkr
	7mLyfhqZ+cZ04lJ/Dzmn03C6lkwaj1KF0NVR16kgHd+tXCEgnD0rhnzfWGNVstJYTIZ7KDP2gzC
	6keFuVJJhViLOkt
X-Received: by 2002:a05:6a00:ccb:b0:848:5cf5:5040 with SMTP id d2e1a72fcca58-84ee478e9f0mr6046036b3a.10.1785702065625;
        Sun, 02 Aug 2026 13:21:05 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe39474fa2sm2716859a12.0.2026.08.02.13.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 13:21:04 -0700 (PDT)
Message-ID: <8aed3bc7d57cca396f7b6f8591cc8b714c8d1559.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 5/5] selftests/bpf: verify zext_dst
 annotations for various instructions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Min-gyu Kim <gimm78064@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, 	memxor@gmail.com, iii@linux.ibm.com
Date: Sun, 02 Aug 2026 13:21:02 -0700
In-Reply-To: <CAGKGUvk1gRbwXgO8eB_5G=PYGiTNMa8=c=f8Yie-ZwABZny=Zw@mail.gmail.com>
References: <20260731-static-zext-v2-0-da4aa161e8c5@gmail.com>
	 <20260731-static-zext-v2-5-da4aa161e8c5@gmail.com>
	 <CAGKGUvk1gRbwXgO8eB_5G=PYGiTNMa8=c=f8Yie-ZwABZny=Zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-08-01 at 23:56 +0900, Min-gyu Kim wrote:

...

> For this exact v2 series, please feel free to add:
>=20
> =C2=A0 Tested-by: Min-gyu Kim <gimm78064@gmail.com>

Thank you for testing. I am about to send v3, given the wording above
I'm not transferring the tested-by tag. Feel free to join the
discussion for v3.

...
