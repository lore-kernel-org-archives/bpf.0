Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1983955C4
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792337771; cv=none; b=KEmtiSutPa5BfMqbLY/Sm/WdccljC0OQJPKU4cDk4/0vu/c/iiX+CrgBB+rKOesZg0BiaIT2xdbuVImt/5PqwdDqvXZ8xVIbwU2NtaLhlW8GGKG5sPjaNqE4+4bEoztj6tJmrvWBWfqhlrBlgpCCFvojRRJE/7tstRXlq6jb2IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792337771; c=relaxed/simple;
	bh=waGPtSzpE3lIXbhGjF91+oeOVlgMsJXlHWJmCr+kn20=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:MIME-Version; b=msO7mYVgFeNEbOqU2M3FaqRbWa3RhZOBOsjyf8lfEspA+YDE0Zwt/BKlZe/vQTm7QitjtZ1WGYObPhW/oRXpp5j/xfdiFwTZjK8thqdoJxyzmX/c6YvnMcPGGhfxLKXGCqkFNAfd4Of+gzxdOV0JCZn6otaoZf0Tm5wC6BtEWM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRyTK6Lp; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRyTK6Lp"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc4b1f7e8f4so569338a12.1
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 08:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792337769; x=1792942569; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ikyHv0vTUgy0Xo2LWvfxOo1dUQuPKaqw0/RogLyXK/U=;
        b=FRyTK6Lp4t+55uA5y7cIlzu3qZQyU4gfkI6NhAWhpXgHbI3Quvys33pnGU439QrYUO
         nCLub49d5RDGVkPn7+Wl+g7kA2avadD1QfKrW8bB6/9ILSbcpv93oITPovLvhWDhpaWT
         zdFrRM8cCIVkoLcc0yDnvOSNhR+FO0keW8tcinnWNM/aMaTHetur4siTLO5kvSX17byw
         cBL7/DBy5KiG7sh5o8XWbuRVWdduFJ2G25wN1vtVQ6bxegBSnTpvuEG94Rf5OEDQK8DE
         mbpvJg5lfvghsYQdL25I1zi69TS9Qj5soJLrNpeGd9Bc3I1sOdtFjrwGvephnpRdObYl
         D7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792337769; x=1792942569;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ikyHv0vTUgy0Xo2LWvfxOo1dUQuPKaqw0/RogLyXK/U=;
        b=uylNTQMIE21AXbIki9zgrTNHWjwfFn28f2/xnPF+4OsTPhZ0f3P0MgHFTzD0xvUxum
         yGBnjylR8T55ODPzv2TIQh6Iv2+qfDXBYKWE1WMQ2GrFPFpjqjT+wz00TN4z418mAP55
         DpoDm4dJa5nrBjTWV1RqBIZVpF9J4juiOTmUuawL3jNGh1WIpVNWpaAZHwGwMYvsQx6t
         thSLy+JimQN6g1oAvewyGB3TYWpZ0crBdrWe0q2xDra7NJMaFjJzI/iJofAqEtLfYvQt
         dOnns+APqLnDNnC4tWqSVQwFleCmnGum2LyE0ujKJtpdvR8/7aORQHsppcfHE4RV5CvL
         Eszw==
X-Forwarded-Encrypted: i=1; AKwUvBzCnQ+g3OddHRUzG5XER32rCzl4Zvi4ervnDm8UXysCq5anJI4WJ+GmKQ22aw9aMzUKOlA=@vger.kernel.org
X-Gm-Message-State: AFq9FYImzTNvzClCRnSzKiZYDia3SENOpnHS8MJv0LSvJPphJewwOAqQ
	RDfQ9lZaI6Qb0H5qqZLXYnYFpa+tGV94cP6HVg2lw+S62fq11oSMvueQ
X-Gm-Gg: AYBFou0GB+5rLvyTZzGCgRvNnv0Wdm70TAZDnHfx24JXroMlZNyhoNhlo3f2RzAfWvg
	1Ur7Bp4DPRS/TNP8Ecxh77bdrqZaQP2kMzAD3YWKs7tzqPDloKydBMTkDS6NSqgMrl+fOI0sS1J
	Vbd0ygGsjpx2JSzNtcUa5rANaKUBZrrbImwsMou6RKa2De+PExmZ3vftNkZp7rFxKsoYRoccM6q
	SlyRpFkumV41dxd7egligGdN9T6KOMqjj09n3sEAc0veol+Re4EuLwOPkQ2/rT1eNQi5M8NhGWh
	nJiscYXPouFjY5q+XyCK+cGD7SEMZa8fqJs9POyUl0ibSZMx6n++BhUJHm/ZX7ZmqOA9pGjXmU3
	hDvshEQdNf2cL1Q/85xT5CKozDkoZdO4mrApILeH3nZVeQF2y22plrlEZqWyco3xOO29Pwv934i
	YotI9PbUFGYyQoEt6GEVz1gQqJ3O7E4WDYqWus9A+//M3EQ6u9Pesx+Ayjrgp/h1Y2ls/YL5rBi
	KZeVLWqzCcUcIIBrnA6+Q07UATXwjySEDMS7UokqqQqlCxWgdWDzHD2EWrCavtOUMECCSnGvKdH
	MDs=
X-Received: by 2002:a05:6a20:a103:b0:3e1:e481:747b with SMTP id adf61e73a8af0-3e22626fb46mr3823122637.24.1792337769231;
        Sun, 18 Oct 2026 08:36:09 -0700 (PDT)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57e220bbsm3069177b3a.43.2026.10.18.08.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 08:36:08 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 18 Oct 2026 15:36:07 +0000
Message-Id: <DM82PN9SLID5.ZJSU0JDPQAA6@gmail.com>
To: "Ren Wei" <weir@nebusec.ai>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <ihor.solodrai@linux.dev>, <john.fastabend@gmail.com>,
 <davem@davemloft.net>, <kuba@kernel.org>, <hawk@kernel.org>,
 <sdf@fomichev.me>, <drosen@google.com>, <ameryhung@gmail.com>,
 <xyx2021@mail.ustc.edu.cn>, <chenyy23@mails.tsinghua.edu.cn>,
 <vega@nebusec.ai>, <rakukuip@gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Reject packet dynptr slices in
 mutating helpers and subprograms
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <cover.1792222148.git.rakukuip@gmail.com>
References: <cover.1792222148.git.rakukuip@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Oct 17, 2026 at 10:44 PM Ren Wei <weir@nebusec.ai> wrote:
> This series resolves the problem across mutating helpers and subprograms:

Not anymore. This doesn't apply to bpf-next, because it was fixed there
a few hours before you sent v2:

  a6f8a67c13dd ("bpf: Refuse packet slices for packet-changing helpers")
  19e6ca6b4a22 ("bpf: Drop packet pointers behind kfuncs writing an skb")
  589998616e0f ("bpf: Let bpf_dynptr_write() mark a global function")
  b7f97db88948 ("bpf: Don't take a dynptr argument for a local dynptr")
  1c19f2b3b2f3 ("bpf: Follow the head if an skb is written from a slice")

check_func_arg() rejects the PoC with "function access to the packet is
not allowed".

pw-bot: cr
