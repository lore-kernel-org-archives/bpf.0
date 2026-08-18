Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42D8286D60
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 13:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787060870; cv=pass; b=VtIWJ37oOx3/a3mwh3cZCxobDVZJHfqKRP9HIkUnI6T3FIj3AJ3sQmtYx8zEYg5lkCNjayPkqUJ9mN+q11+vjA8PVEjxieHp5nSmu4kHW0tz+1/LuwiqDjFvQZaz8DwSImCfJQLZOAHioXOZileWYLJe8PLjbt1l+jviPDxjvqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787060870; c=relaxed/simple;
	bh=H3SH1HFJdvZaWM1qKEYTxDfn1n4vk3W5t9zcxDGkcso=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=nm5XBJqEOP2ESdZE0/B/xtIuDUiZkTw72lp6HTES04N1Tp/q/IF5+MIFWwyZ/1LhTjpyBtpgo6eomShElXzNe/ucM/EYE6fFyiGempqsFCo9qRCbWIVMt4niJaFoyziEPXcsycLsoYayGEkFe7C2cjv3iCeUaFirjq0W7iPdL5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQx8ITYQ; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQx8ITYQ"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66c70cff944so4123165d50.0
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 06:47:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787060868; cv=none;
        d=google.com; s=arc-20260327;
        b=TYTHJBWVAr/hhF0WAE9p/epkkxVk5pzN5Xba7pCMk5zzLsuftz7IqRMIP9QFaP8Pb9
         jxWyJxrVfv6BdUMhG6eNhzYJyxSgwI1MCi4XzmOs4XMDZukcVb4kYlKJGg0hoPTMib8K
         qgYDyz1cH3d+kQohq3oD6CWSVIY6ZHM51hjNQkMDnffASxi+uYpf7wsFCB5+ijUTPRGn
         8oUzOKPmUYUfwt1kXjk5qr4DThYyWOMIv1OxrmTT4arANc9bgzrLkNrqKF0wEfIpXm0s
         hTgaTHmjcRVary20q92qCGzP4edE08sOODIWVPMT+++obBsVIvPSwb9D4EsB1MAQDTPF
         /phg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=H3SH1HFJdvZaWM1qKEYTxDfn1n4vk3W5t9zcxDGkcso=;
        fh=NPVFJnkplS0XBaxDJfGZcLOa8RPQHO8kfhXKRMGAFb4=;
        b=UMlfz9Ecmx5uB7c+soNTmteyhe6w6O60UTQPxxPlcvw8lkGevew+g+vm2dWI1gyLnA
         s7g5uHX8Ry1mw1z3K+xM7O6DXq83ANcAlbTXZCmnOVxAwYx//O/LklmeAtGs6C3lOIJS
         BZU33oRZS0YaGDndTK4qIUND0oZm9iKzxu5VTYsKROLkaGWB0kqEqWzJ35VZ1Y5r2OHe
         jvwiKNIwg641PcEyd84WNEx3BU+O3PHTL1XR0VsNBrm+4IIgoWzGG3pWbO/NWh8dYpYF
         OVCUmY9c6HwpTdSRDq0Tja3H7kFZpJSYxOJry+oHcvE6pwlb5ieH1OSNMU93qkNQ8m3B
         RhkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787060868; x=1787665668; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=H3SH1HFJdvZaWM1qKEYTxDfn1n4vk3W5t9zcxDGkcso=;
        b=gQx8ITYQG1SOSYW2uzsbkOJdgVAg4ZrSI3aQp+hC4HtAfScGaOZJqmQcn/DTiyTdPy
         QNcBjTsskFmOngnyoYEG0vtkRACc0+2dFQindQr2oX2+kNxjZxe1AogN+gXVX2aQzFzv
         xi1bukROnirZJ5lIk9X4pYgUddSnHMKbkRVxzy5dAwM7GaABLNBzEHcTNNpUhH9ZjyMO
         JHzM4QEbgFeUB0kPu5DPL+5r65EWk4KD6GOAOABj0jkHPmCAsLA2STZbOnJ85ERSTjOB
         BJK17wvAra4kAF6P/1XMjfL+930ZbAfdJR/UN2f1bPqs9yL48PFbd7bWw/2k2R1JSN2n
         PH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787060868; x=1787665668;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H3SH1HFJdvZaWM1qKEYTxDfn1n4vk3W5t9zcxDGkcso=;
        b=p8DrmD8ljOvXndNLdcUu1+k/8ltQkeuBbvlPEaMInhqFYUrt23NH3LVE+Aq/eqvWQP
         YRNn+arLdGYtMpJbrSDt60N4MR+ZA4OBnocfetsVb0czONLMdOvDRpqs595Tiut8bqsz
         a5sA+/CRFxe59MxK7PGXWIEgnxilf76IwsiVu8/bJcD8ngv6ZnnQVAUDGDnsRuASeCJQ
         GducGTLB4AByx9BvdIjozME7RsXz305OSWxyOi4maSzbnUjxy4HNUcmrvna1FLGDLL7Q
         S2zwiLyA4Jrtp+pcfuDi8Db86JICjFzXPBZhBLXrfen1SG+LJFlHPEyE0VRyuyjzFN3q
         mcdg==
X-Gm-Message-State: AOJu0YzQlmm2u+vaahmm0ktM5BgIxqt9RO56P/b9t7bIEzRZ2L1A+sYo
	4FVFCFeyT/uYohveyA4jNCAjHj1ULBVrvtanzROh7JHD+tHy4ExR4RD1CsQeHSTh+R2LBi/eSNX
	U0Epb8BxhsyJquaI+B83Jjv8qsB8y0pWqaNir
X-Gm-Gg: AR+sD13DgneOAoibBKpn/F+3VqH8x1UbxGT+XHVoOfc1kwjrrWG7WXN+XcDXjOZyM9u
	sLZg+oxrlKffdGD8i8gWRIWQzs/3usSSxP7imispyi0veUzYUVcBfz7KZOGiCy+NzzAxe6Lw3oi
	7Z0DN3WN459a6njKvMnp+Zy6z/0cZDUswtKimAURVSYZIwRlIztl/iEE3mxg01IAmCeHWjJ8mVl
	9UTQJ+SEODTn8bTrebXtMDh0GRt0ahwvWFghD5JYZ6qpmX/Ab42Gx6wLmRzRBzwjFPQnhFLwzxz
	kEfclxBqEryiVHiWwfHGw15BPAxq93QsI0q/LWdE764UsM6rmK2LOKNv
X-Received: by 2002:a05:690e:d8e:b0:668:9e51:5239 with SMTP id
 956f58d0204a3-66c72d2ebffmr11030870d50.44.1787060868599; Tue, 18 Aug 2026
 06:47:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Totoro W <tw19881113@gmail.com>
Date: Tue, 18 Aug 2026 21:47:33 +0800
X-Gm-Features: AcwNN1VLvj7E2BWiPMge0bDrJ683bIMNvk13fS_NU-seSYzXuAkPs-jRqTOcwrg
Message-ID: <CAFrM9zvpqwycN50V41mh4wtiyy+-KNVTandqKo6x=GXWQSCp6g@mail.gmail.com>
Subject: Introduce an universal BPF Builder
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

I want to publish my new tool to streamline the development of [e]BPF
significantly,
no more various tools, just one to rule them all. Here it is:
https://github.com/tw4452852/bb.
Hope you enjoy and feedback is greatly appreciated.

P.S. Don't know if this is the right place to post, if not, sorry in advance.
