Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C361DF248
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 01:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773364583; cv=pass; b=jRa+i1J1l6MgLxis661sE5Y4nJat0I2/U9cuoxivz/FOQReLpLvuGlOppH2cj26zmGvun5aROT4hceib2wjqnRV/cVw2uWOc0KJefjxSIBSe7G4F8Z9sHeCxELc0RuFdEhInB13axUEcoH0C3y4xIBrNCK0pqVpwdWxWPYVraQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773364583; c=relaxed/simple;
	bh=ODWaR3nFXxhTq+knkAPMZkyyR9eyjra/Z+l652kZT7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LekHuJj7pcc/78dj6QNPpKuupiAjM579nuMwF/VGynHfgPugDET3i2ur7P9mMoXrS4wozv4UGzTBEO3JIWHzsjL8piRaFPcf8ns1iR1i7Uu/mPQ23ZKtXH5uLlyJBOusaE15G4FpxeRWTPs1BvxJJbGRGanrKe7iUuhuz/mShWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbDVFGue; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbDVFGue"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b93698bb57aso325171466b.0
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 18:16:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773364580; cv=none;
        d=google.com; s=arc-20240605;
        b=QQXPZXhUC8IcgwMPXWKEUO/IvcTeoIg7Qrq+rFOpzpLpwTqPwh/K1jQqNHJ2RyB2z3
         SVCkVgjN2SI8+rdJ2H+HvaoVsEvd8xPC7f1Gm8+10z+Ful+IC+FVlh8YEWXkhAEzbqLf
         VPgQf3EPBoDDQX8EU+TawgUnJsOyEVsIAVdgnM6w2giCNiyrR1MnP7m0N2mO8XIraR1J
         Xn7CnZLhzqVPa195qWwk+bzNKb0A21YhCR4/JGJKy+cQPxlioSPhv3QUx/ARNENzLHW2
         gyTcZBy32ROdehkgbHSGlw1Dn3I9D+Zqxl0Zy3Oz6FmKJ8HeAKdsdsxlO9+pJ72N858F
         WYoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RAG7cR9Bz0TQVww/2OwxJdM2p8V7n9WqbxWdKMi/J1Y=;
        fh=UoLNJr5bJQ/yjkafTC44ES/40zZbtinuL9cuy+Q6S44=;
        b=fW5hjyARFKxeSu6rST+I1hbHoc/t7GobUOLMp3k6kGeS0pbKZ25kqeAEvXHZ75J/7y
         ejJaqN4tekny1YAbAV8eIB0fuPDJkrQ9v7SzXNWZFtDcuu3qPwhwxveindDKsDEPdfvj
         E4p2I9NB7WsOAfWS7RE6Hqt7PuclpUT7B6YSWOvp7KX9n4Z9K4P7lVywBowq7gDcQDh/
         WNZT+Qh7VnMiTQC/09boD7ULGWV+I/+SPZHnq1JvL2FarXJqKPxk9H23yOfKPC9rn7L8
         dCOfyboTLTfR+yYYZefCwbpVYIdMKKzur6bR5Qxg/Ule5joWUJmq8edclzIQAQQPPCcr
         YYMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773364580; x=1773969380; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RAG7cR9Bz0TQVww/2OwxJdM2p8V7n9WqbxWdKMi/J1Y=;
        b=WbDVFGueBvQlu0+c7FzL5lDjB+51y43udKZrgsWPihasgVBhkZ9+S8yamAaJDSDPeg
         1ADSR0KZYcarYQ97S6OqNrHMpckPCQPf2OCtESKEFhrIhaEagWfFQ3mbgYiQiooqpgLH
         FPvfO+aOpbtr9jnYekOQiELt3WQJqD5E9cqrEQCfSMBUzFBjyr2C2zYPS1NTHyOWE0B9
         uQ4NnGnAnmpYnbChKZJgLMIYrYZgvOW9jRu8VEFGF8yYynudVwIli/qLNsBkJDJ3q2qd
         msNzG7Ol+1j2gy4cQIYeO28Fmz4Sbp0zmtqLQ0TMMpw9lctanrSpZ94v/sVg6byUxZhM
         ZEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773364580; x=1773969380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAG7cR9Bz0TQVww/2OwxJdM2p8V7n9WqbxWdKMi/J1Y=;
        b=mSmuU9XP9R0msZMUb0Ei80wLkyC/MN6FhkYgkXmKXNVe7gRkD9ApUgixheZv7zVKUc
         RPIpDTV0SSTJ9fckwqoS7oGHaANLYm0w7YLV897K5nyKY4nYz0N2CUf/g6AzYg5tbr+O
         sK81wPw1V4UuD5WCL6V9JZ9+0h9q8hEkkIlb6odfIaL2kgu3i6dwywr2+geFjxKbqPCw
         nHGAJh51yopS4ye0lEqkyXBK47LnZ4PdrKa0tNSg9OLtQcYse9spr43csw34F4Ytuco4
         lN1IbTbFfv6OhOZdhQbY/AyQ6Vz1gP3zhjsqiulOQF3GH5zQTAn+cWUqLaQpqbr1hdhg
         7eFg==
X-Forwarded-Encrypted: i=1; AJvYcCWs5uSvn/4hEyuqw4DGh0N8ROLxH9ktw5616KfZKl7YbIWPsGZEt79uaZBspujiGXYpN4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx18k0aTLLjRqbwDQ7LTP8C2e0kGlT/wpNNyhAewgM9Ge/+ULaI
	HxxzTdBFXbPPOf9R199+JMS2paejR+1vLJx1uZWoM1qcCJzAGv/3tiaFbCnFL7TW9vde51hTa0+
	QjVduHM5RDlN5s43xonWPYAlb+NsdKRw=
X-Gm-Gg: ATEYQzxNpJ7gHysq7QbshBbrAqdAWTx3g+kNuyv9mW4adUc+8XMxLTWczSRVca0WhOy
	5Bl9pRwSd/XHWKwxCqVGSRa39fZFwf9xctcB8vJ1x2SmIqqS9fTeiowXmAxBYDNH/uVoDuLYz7m
	4dL6E6Q9RhNaWKd0mFZjONM9ZGsWDHBKfh9iYqckPnwrF0CxPNnqfv0IfVKybyiYihTnQTu4yM7
	IZM7DYE31wFQXcxXNlnSpJKPlOaaJie73+xwm9DiTeQHBGRC62Nr0m4ZtvdBXmqU9+z/WdgJ+9z
	Sw/jsyz9GkxnpVyDhts=
X-Received: by 2002:a17:907:c1e:b0:b88:4f25:81da with SMTP id
 a640c23a62f3a-b973f6eac02mr376987366b.0.1773364579979; Thu, 12 Mar 2026
 18:16:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312183817.104878-1-teknoraver@meta.com> <20260312183817.104878-2-teknoraver@meta.com>
 <20260312173041.36bbfe4e@kernel.org>
In-Reply-To: <20260312173041.36bbfe4e@kernel.org>
From: Matteo Croce <technoboy85@gmail.com>
Date: Fri, 13 Mar 2026 02:15:43 +0100
X-Gm-Features: AaiRm52yizaDdjEL-sEiEhHWB1GeEcg30yq4KwZRdHEWmjoGb6VT2S7HOf1R7hY
Message-ID: <CAFnufp2BbYu4PcPoYEL-Z27S1ApVV-VS2Dh2DfwBVxzC_tUwKA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] e1000e: add basic XDP support
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno ven 13 mar 2026 alle ore 01:30 Jakub Kicinski
<kuba@kernel.org> ha scritto:
>
> On Thu, 12 Mar 2026 19:38:16 +0100 Matteo Croce wrote:
> > Assisted-by: claude-opus-4-6
>
> >  .../net/ethernet/intel/e1000e/netdev.c.orig   | 8529 +++++++++++++++++
> >  .../net/ethernet/intel/e1000e/netdev.c.rej    |   46 +
>
> Well, I guess this gives me an opportunity to test some new patch
> ranking features..
> --
> pv-bot: slop

Oops, that's a leftover from a cherry-pick.
I test the patches also on a machine with the e1000e card running an
old kernel so I move patches back and forth.
Surely I ran `git add -A` thinking that .orig and .rej were in
.gitignore but apparently it isn't.

I will submit next week, sorry.


--
Matteo Croce

perl -e 'for($t=0;;$t++){print chr($t*($t>>8|$t>>13)&255)}' |aplay
