Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2FA2853FD
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 04:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791261451; cv=pass; b=hy3oJM56486zlcmItBpSbty4aIz+t30oUkxPEZyDoS8LjaeK41MR2U8nniyjhggD5/wuEC6ylN3fopVUnKRoIway6Ji+U/zre7urlh6PTyCpQ9ffrq0BgYsRcBjHMmORMnnQagtCB6/gmbhs3oOZJisZsnLLDNhTd06SYl65Z48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791261451; c=relaxed/simple;
	bh=0AndkzISWXJsmL1SMyRIFmSUfipTv5pei0zq8nnuLEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KTszOUPRgmgZXX0fefoYoU8+Y4H73zpIoM0BTWndOJ63y/NJQv3mlatZzosmzh9PFJbtGbJA8zUbQuzlc27hUZ229KLlRG205MVqP70yFxBj9yY0HBGfmlLxu2idHmF51tjWJW6v0bgjsVNq7DzjG3JnC3Cj+JrzSWNVLJiHxU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfTmvTjY; arc=pass smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfTmvTjY"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-78fb9d46f0aso52053137.0
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 21:37:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791261449; cv=none;
        d=google.com; s=arc-20260327;
        b=M/7yUzgMBRUtO+BSa60U9lAW63YGts2CjupmIqAo0K8bZKXAQE5hC962UZ8IaxhXHI
         bh31lDH/tirN+FpIVEFlmqBGw8mx4xEIvfjVj+10QbtzHwNd2ZhpCaEli/2I+LVFq0fb
         ZB5dzaxPvg68fjiPHUQQkIY+yI2MjLHeaUE27exWMUlJtagtXDo/ltyIr03K2AEtVK+e
         wVJeTySUs+t2QIyK9LAe84941UkYS8taWmiCkw85hRkOGndorBe2EwuCgeEtMZEvbqkJ
         E2gERPXaEP7TcHRPRe+PuUSBXx8u+GU0AHre1+VJpBZuzG1BhaAKTuVzjSCD8jZp+25G
         5sAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AY/4/mZt0eY3/2zGQJ4VfDnIKBzDcXDkb0pfkxHi03Y=;
        fh=FLsGKv0KS1cFJeM0keSfqYlOtSpWvpOnjaZhQa4v8ys=;
        b=rjY3b5jh4pToph9ECLWY8AMsnN2yn6grT4dr/GPKgsOitIyrTgPtUeZYeA9Voto0g+
         MQ4b9SqDt7HT7wRH09RWbsVwzPTx9YT62cUdoqlO8Q3wBSuJisinR1AcihyjiYZKKiMk
         f1WUu3fsbUnuE/AZ4bUkYdbLLLfDxE5qfNDAqUQYYhyomhUHoaAxlgGBuB3OYIEryD0L
         AOEfma7k+0KtT/q5AxjpMWRdcO8d6Xh0BdVlbyCyJ3i8Gqcq3ZRznw3wMUZRmUQyIe3l
         jAFlVpSm6YMLZ4xJHD3BNR5Cd6BdRB/V/vzvN+cF6ucstYwmbJtqQa9kFS7rolNBuT2D
         mrYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791261449; x=1791866249; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AY/4/mZt0eY3/2zGQJ4VfDnIKBzDcXDkb0pfkxHi03Y=;
        b=nfTmvTjY8Lbl9tWgkjP0EvD7OH13VNxrkrkQrITwbHmUH32shShBasCmrT/vrjZQKX
         6jVkDDRGNQdyN7iqoHLz20P0DBhxQXXQfwwc+SWu/5H2rpjsvJ2yU39e2cvj2cIvwnWq
         xLEyofjFxvACsOYf0XhAlC0ZlARag/XBH8Bf6gYvG9kdoegUSYItwYd0Pqz14KilgpiP
         todinXfi2rAofdv8NcYMn4KswBO9LNip5SO3PK7k2hfRc3E5BlmsBk8EPv0a5HT084AZ
         gyFaW7XI2USyr7OoJKQU65wymLk9aC19kINKck7Q4i7eH63QjJ5ZkzTrcrI3ZZ61oSpF
         C+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791261449; x=1791866249;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AY/4/mZt0eY3/2zGQJ4VfDnIKBzDcXDkb0pfkxHi03Y=;
        b=EQ/jWG/dciUnYBVWq9cCVAmN0skjHapzfVHwSkY+0RCWcMdW7274ipuTRZwPJMUuda
         qPyb3ov9z/AiIjVphmN88Mz3MxtFIWCUqocQ9SEbsVXfkrgxy+yF1JgA0ocggPyc+pmJ
         YNkZAHP1CniramIG76yz4fHm5yWDGzZWVQYNeT0gZ6bVaBR65La6qanFIBMV2X9BkQzG
         ZLlkHKdlfMKtTMxsxL72aJKj1HUWeqqHMJUi+R3i9QIoNdQsKrRFsK8Wr1cHK83FHJ6M
         djJz2wojcl7NVXgQBgDdB2HIcKFGftizKzHHyVi9Nu2qVAsIpHVOxPHddj+VQJiTiIcU
         U6hA==
X-Forwarded-Encrypted: i=1; AKwUvByNUfea5T7wQpGWFWV8Gkgx6Bsi5++DLgeuksF0aIL9cIjl3mgaxktNzcz8NZU3BVhlz7Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMBblsbEdS8LEdI9bdMw1BXiiCf5UMHxK8wS6bJdViY3Sk+F2+
	t8KPZc7T1ennrSIiFN17Ptuwu29AQ5dMp1JuvpZa+8kLruoMhzOpF3D9XJvUy1SZpjcslIi5k/3
	LgCjLAfpacNIqembcVIMK7NP13UZl/P0=
X-Gm-Gg: AYBFou0feAh9nGMg1vZqqRWBGzEF5iuEKzWXOcGyePPp+8A7Kam22N7O5MlZiOSHFu/
	DBpl9U5faAJBaZyRAcP/ekgaB7/NH4Giby2AFF4WIWCyb0Oda/qKOyqVjyXpFJhU3eri1ES3CUf
	qSTLeLDvKH4nX0IrCP25koSkMemY7Nv8MBUN24hhSUjrYvbTD3TzRpHV3gLw70QOtcfhZYgoT5n
	t6VVXcMgM5heLaks/cx99WyoEBoOKFl/od+3eVB21ZGEbWNGaSUtzeP8EEV/UEfz6SloZA8fQcv
	VkU+579bWR23wSk8o7TsnLnGtgYgfwXPogQsX+1wf1pgbbWDA3eq0NR5UT2mUqNrca9UDV4gRUN
	9BeLebDE3Xf1tJ4tSzi82ZQoxSVZ57CZ4KwjtT9H2J3/4z41M4FuuFL1aKDRmCS8cFC3mx15Nm5
	dwxWOFzyspYfde340YRVSyO7mTgDdcldj+0urw5tg4jTDv
X-Received: by 2002:a05:6102:915:b0:7c3:9b2b:7efb with SMTP id
 ada2fe7eead31-7c87a31a2demr29458137.16.1791261448899; Mon, 05 Oct 2026
 21:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-stmmac-est-reapply-after-open-v4-0-9d4366587b73@gmail.com>
 <179082834895.31693.4009727999698761506@kernel.org>
In-Reply-To: <179082834895.31693.4009727999698761506@kernel.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 5 Oct 2026 22:37:18 -0600
X-Gm-Features: AclHuK-ofFt6slNz98bqVopfHARNnkiLXB8RVY7WAXdbkjgJ1j-2L7i2_F7ye-0
Message-ID: <CADvTj4okT50YYV=t6ZHD12K+XEBpz2B-FxE6C8ApkQeKXLyt5A@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/4] net: stmmac: preserve and restore the
 installed EST schedule
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jose Abreu <Jose.Abreu@synopsys.com>, Russell King <linux@armlinux.org.uk>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Serge Semin <fancer.lancer@gmail.com>, Simon Horman <horms@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Richard Cochran <richardcochran@gmail.com>, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Rayagond Kokatanur <rayagond@vayavyalabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 10:19=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrot=
e:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

My additional replacement/error-path fixes were found by source review
while integrating Lorenzo's EST work into the larger stmmac MTU/resume
recovery series.

>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

These were source-review findings, not failures observed on an
EST-capable device.

>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

I have not tested these EST paths on real hardware.

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
