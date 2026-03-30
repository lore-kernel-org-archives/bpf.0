Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2387E311C2C
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 04:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774844634; cv=pass; b=O+8VS8aSa6ASo7cHl775PBvC9R16Qm7Bn8QpnTQ7kAO6n8k8uGAkspwpAvupYBtxfiwIwi4rTxwAlzxFi+T6qF0pRJufaGUGHsHKLJh1/ogY5P07wnJtZJAISihifso00LhJS9YylMKojhbcOOGxPgjH50j7ce6IqngNh2siJh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774844634; c=relaxed/simple;
	bh=47k2KtJLFlgZV7BeavIm4W309ubp3tqc1s1bO+AnlXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjlSeIktvVMpUTd4TSsxNFOsiIEVVN2/OjYBYCYAPbkaOR+0oeHthsQnLzcvPeM9KAP5u67O3km3lj67vvHr63EgShvEAr1IMOngTCdpU9LgxY57uDIXsEXzc09VmSnjyUeyw61/Xah6+kfvu0Vv9e23ZpyNuotmzNEmumz3WPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4IzGVJP; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4IzGVJP"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6501d242e2fso515094d50.3
        for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 21:23:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774844632; cv=none;
        d=google.com; s=arc-20240605;
        b=EZo5lm3M0WGUpFCZVtdCwxN5YKEN9hhS9puN+vl/TDzbrk+EvNcRWaDG+H9t9JKKc7
         UEa5kxqcph8YgsxykpNJ0IkTH+i06bahunq2PhOxsmiKxQIbRhEOxAtcpi1ye8IOvAov
         6KTC39BqdHZMGNjn/HqKd6s9paNeyTJ1x/zMIL3aBqadTLI4VXTNkaxuBrHgUIOaLZQp
         wYVOTeYT8fC7KaMUsm4O8M/zWTPE3ZVJB9LBr+WqIw+mIfsQk1dwdZDDvz4DeXXIERRQ
         lb/Oi82nXIMvQ2VhEKHvkqHVGCRwMHTEmNwPm2xoiS131ojC42pL/MnEKzrUw8gH/8tr
         MDDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=47k2KtJLFlgZV7BeavIm4W309ubp3tqc1s1bO+AnlXE=;
        fh=tWp5l9su+Ihx+ASE7utZ346O65W4qgbBCWBKNw7rGVk=;
        b=ACSJZeQ/PCeivoAPZaNGLzqjY1cYms+SlxTSWGykJUcs2ovuZb0NTE7NDii13Zbcan
         FvxUfnPD6lpAehj7dV8K90X7yOu5UNYCn5VVJBM3+JzX18CQVv4CSgKIOQvLT9Kjd0WF
         vfq1jSS2HFREFSmN7+EPo+nLowPJyuGUmiYDlWFpm5N1kLD3pRIvsGmDrL0ZfUyTmcgL
         rQ9Qi1NvsCgZAvGZVnktVMKCVBCqRVOdOU/E/C3ikqLCc1EpQNzExCEMLWktX+Wkk8Ru
         zIMaR5hdIZCZ3BRfJLvDbsBAv8NzGm1vFDNViYFSE/2NS1UK4IBhiuLfHz99NKLWghVT
         zXvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774844632; x=1775449432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47k2KtJLFlgZV7BeavIm4W309ubp3tqc1s1bO+AnlXE=;
        b=O4IzGVJPphyFOlthwcYwsJrrr22cGIHGWNjN3ZgCcYdeHDCpP3r+vz6lHrRxj3UxVm
         gPr1oAXQ3OVnppktqAha3ZIWRj/nkmf/H+Eewu8rjtquRjhi8rPbQYxWKXP2iHSy7sco
         jAih+k1Zd4M2PctyqRIS/toh+KpEklLv6wIAJoZM/IYHuh8HoxNzuSFypk1TJHUhqLL7
         ipjqUv5ps33r0lKOcO7nq5W5eOSoHi8MHJaI+rwkCYguVrq0U7iTqQRuwbQakwYKucMI
         uvlOxtb+rVymg4B71V3VekQ43NP2Ez6bFdL6kuy539RpSOLGDPwG0VCy6rvvManRudnK
         pRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774844632; x=1775449432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=47k2KtJLFlgZV7BeavIm4W309ubp3tqc1s1bO+AnlXE=;
        b=dEoLGZh584+FAyV3posVtRR02dnJAnqGnA+6sQBUtA+LVpHMKN5P5JUEjAWy2u6mlw
         FpEH8rrpvx29YITSLPn+wn1yb3zOt3tSBGVR7a7g+oKFoDPwNb3cvyT1iHt2gHhE/xw9
         M56FHN5zdCQZG2vMaGiO6BAdy9K9G33FCkuQCfkNwzJ/hx+jbpnpmJrj+iDpAf5zDkph
         xBYFl7ANUAnmwchdhVj0c5crcfRKoZwcPUlEKiAVdzrxTKo960FgRdlV1Jj7d5SnAziW
         bpJl8eiNPwTT/b3csAspQjL94fTmbDGYHdWq5GIPzWOTU81IfJ6H+JAOkvpgqTUkEfSV
         FqjA==
X-Forwarded-Encrypted: i=1; AJvYcCXp7C0Ynyx0jSf4rHPJh2AzB3IHE5m+OUCxSwMc76yWC+0zVGU63jKQVKKDwPIoIpZnEJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpO7HbVfKIGzqzQHYyimuYE85UwL/+xLZrxLmE48N4RSTsYFTW
	8Oajes2dVjaR7Lqvjw5y0gjPTtmE4G7wwHYJK01NzYdSQFRqzDQ6WCAuX4d11OXBwAzarOasMjm
	FrSV8ReGMB1ZuiXGlouJf4Z9qiIdBEQQ=
X-Gm-Gg: ATEYQzyXHkgd6PeHUVDhYQgX9f1zNWc14xJ51PzT0q07yNLG/XvdnZg92YdSL7BhKCW
	zc6OEkpAw0vvUVeK0Mh3UHGiBgPG0BvaULhQE9/S5PXoho9W0I8z9zFOdCAh7UWZK+2HHehjJ2O
	BFnKTflkG3DJPMb4YkUq/gdNEmF+cdcWazq5sl+tld5wGqNcbpOMxGrmqJYuqwqasTslremmNQt
	j/ibJpC8Lox3FvKiaDj6ZC0UYQPIUINgIRrtNR/cmxRpqypgDJdEdQDvK/c6E+6x3tc+b+QPreg
	6kF6zLyIB3Nh8fkmRtRcrFYTPYOoXWWSLelBqC5g9vW+qm2fWyuaZ1D7keI=
X-Received: by 2002:a05:690c:18:b0:79a:b00d:c863 with SMTP id
 00721157ae682-79bde07ce0fmr108242067b3.47.1774844632115; Sun, 29 Mar 2026
 21:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260329161751.1914272-1-sun.jian.kdev@gmail.com>
In-Reply-To: <20260329161751.1914272-1-sun.jian.kdev@gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Mon, 30 Mar 2026 12:23:41 +0800
X-Gm-Features: AQROBzDnXYc-BWZEQKIqLDNt8-oBOgGJ0Q32XePgq7J1_YTx1z8kBI9nA7aPypk
Message-ID: <CABFUUZGmNR_xEsECjhF=WtitTHiSxM91-xDobo_h1AAYNADRvw@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/bpf: Reject malformed IPv4/IPv6 skb test input
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Syzbot has tested v2 and the reproducer did not trigger the issue.
Tested-by: syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com

On Mon, Mar 30, 2026 at 12:18=E2=80=AFAM Sun Jian <sun.jian.kdev@gmail.com>=
 wrote:
>
> bpf_prog_test_run_skb() derives skb->protocol from the Ethernet header
> through eth_type_trans(), but it does not verify that the provided
> linear input is long enough to contain the corresponding L3 base header.
