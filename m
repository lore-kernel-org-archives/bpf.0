Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C463C2765
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 19:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776714165; cv=none; b=cTRy8t5EqsDpZUUe9AuOiSk1yEyW5ZtrllQVnqDD4rGK4np1CY1zIWnX2qsOIvzdMz3y4HZzimentGu1ZZxwyb+jfaYUF5Kd68v5uTNXvYPMrAiLET3DLPC+8qFe3bFqlO4ViDY9F0BBAdulm9A1T/qWkBaVKAymqQ7HC7SN36Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776714165; c=relaxed/simple;
	bh=gGhv5aBvag8GkJJw8oK+HvN5ptj86XyPHMattSfFigo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ICITDK0qqGQDP4bAET8gOWIYIu4rvOamiSGkuczmjU4FaH9VBh42+LLfayAgtliACRRzrmjWrQH4ixBFnxC0q1kXhr2Ioyoctsh3dWBBSvtjjgXccEvdADyAYpXCjnqJqAKlnW4i51FsVLiToOSB/VssGy9O/5dw9EJOQEyKnkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioJuHZ+j; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioJuHZ+j"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-78fc4425b6bso26538697b3.1
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 12:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776714163; x=1777318963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ar9A5QrYRWGb5NIZabW3eNiZEMmSWnS35Z/zWd2ipnM=;
        b=ioJuHZ+jKiUhtlsNSOyP3QlO4YWFOh20tActa3Kup9u2YnAy5zNVLxuYYRAeKcAc1l
         sX3MeNQFoCigoYRqXNB373NG/iQVAhrotHG5wsmPUES/UE59cNaSz9jSa8mAjDzTvpZY
         rCnLpv/i7T6wbWZZ70HC8zF7spr3wFQwzr2vPdiooaRgQgplZoaCxPCybss+1EpILpty
         6CP84QEcyJc6fyyx/Uh45pHH4RCQ1efS3KyoGmjuXXbphWfFJDUdsoIDcpgvH2VgVcWU
         I+bGIVjKGb2eJuRrLi/dv9azrTqFonXSNUaZy6XVNPwyCVSRndjvYX0+sTBQ/FtLqNlT
         T3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776714163; x=1777318963;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ar9A5QrYRWGb5NIZabW3eNiZEMmSWnS35Z/zWd2ipnM=;
        b=SeKFNzNvpWkaUZmLsxbW2teYtrDa59HJ2X6//hXvoIXjb6WkSySVGidrG5XawPAkhA
         1+Z3Z1HFhZsPAYCaxR/Pb/cHmbH6NPTeznClt/0XqrZBOTDPsJTEhwLzwt5f/4X3IE9K
         uwSLMLdmWG8pzXoZEr6wuPJG38RnEduyFqhgWBahe8fgiINjLETLs6iLz7+oUK9R4zlZ
         Rtb+PhECKIHkn0pu1Nh3xZuV64lcQ9cHtFQ5QsO0NaOXPc62rYy0rEoD9jiJsytaDnVV
         stCzSpWFSB/d1Kk9vtrrqae4zciURUMXxke1ameGdxHxM7FOrm5sXElkm3K81vBYWnYq
         lE0g==
X-Forwarded-Encrypted: i=1; AFNElJ9sSh1w8xdjJE1iV4eXEXGkjBfP+LOFWLDrBFQIwdX1z/EmarUFurYumxRUo8tTkBfAVk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4VFik4UQeX0QNUQgxYhrkx737L/DCppgkQchThil8zybrdIkB
	ijz/dgv3Y1UNEsm5NL9LYcKRNtDSmKgLnycTG/ar6Hf/ifdQeNMFqA3z
X-Gm-Gg: AeBDietpsyNg736YeJFK5xLdrVKY8jfsEG4kdEMAoznfJ10aBbxhX/owGyDksd2mX4U
	R7iSixd6DEzp+TV80BH8A0Kgf3kgS35E23Y0wiSRTD8+Y5hFhanv/tVZsdm24e1/Ztf2YGAGZQh
	G6s3aJlxdVYke9uhhkGMK0KofByyIju0K+DBmsy+2Kj6nGogATAqVw248gT9fIv2/eqtQRA3ueR
	+tGfjEVJ/s0/JpDUX80EmyWg6LjYT4czUjn3XwYRO6qtBimhkClyD2FNIpTydbtHz4NGtEYbXP/
	x8BxTRabFG/j9DYLnWwtWpP3U2jBAc8k+SyAL2+CbU67XtIQtHzSOkkYDPNRCiAuDO2m++7KzFT
	1+HqJbDpFHox97Q3jjqOYNMtTjaRFvAtx/QJkYsQLkEF47Ky4NJxyXqrLYmmXkhIbsFRLBmbs9Y
	wet2YwG6dliFQdMQn4lZ5X37fkf/ehN7WS7AA/UVKHPD4pJnfT1KpgvNgPW3ayFSp++QYD3MERq
	QKUDoxPKxEY/7wBA09hHmvnmw==
X-Received: by 2002:a05:690c:9201:b0:79c:ff02:a048 with SMTP id 00721157ae682-7b9ece6ad3fmr142245957b3.4.1776714162988;
        Mon, 20 Apr 2026 12:42:42 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee89b259sm47551907b3.2.2026.04.20.12.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 12:42:41 -0700 (PDT)
Date: Mon, 20 Apr 2026 15:42:40 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Nick Hudson <nhudson@akamai.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nick Hudson <nhudson@akamai.com>, 
 Max Tottenham <mtottenh@akamai.com>, 
 Anna Glasgall <aglasgal@akamai.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.29f88e1183282@gmail.com>
In-Reply-To: <20260420104051.1528843-3-nhudson@akamai.com>
References: <20260420104051.1528843-1-nhudson@akamai.com>
 <20260420104051.1528843-3-nhudson@akamai.com>
Subject: Re: [PATCH v5 2/6] bpf: refactor masks for ADJ_ROOM flags and encap
 validation
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Nick Hudson wrote:
> Refactor the helper masks for bpf_skb_adjust_room() flags to simplify
> validation logic and introduce:
> 
> - BPF_F_ADJ_ROOM_ENCAP_MASK
> - BPF_F_ADJ_ROOM_DECAP_MASK
> 
> Refactor existing validation checks in bpf_skb_net_shrink()
> and bpf_skb_adjust_room() to use the new masks (no behavior change).
> 
> This is in preparation for supporting the new decap flags.
> 
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
