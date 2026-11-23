Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795393279;
	b=180WKufS3a85ydcj0xgNKB2xU2c1IJ/umVJ5hqDrnsBBFuS7WgrzxDuHO7FGQ8s5Agvf
	 eWnMKyEnfOY66/prgdLgLduYZPEQ9ib3SC+IZgMnBpqvhkrWGyATlJHfwy3WHjldkqEOT
	 +xz98sq4Y9blC/vkAsInUxGRAQf6X8/UWA1WNgR/JHdZQIhVqqeLY1Be5idZYGx/1okst
	 EOKM+YcZqFOQPPGRTVMDe3HPXGxqL72IkNmY4HdvQp862n1Is4jdp/2G7QnXwzVmJ/D3+
	 xyfcpKTzyikUAvL3JuMPpUIXdMHjkGvmF/y6yC46VFW8w9LXsY/ZXMiCwBpNimpVsCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795393279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=KF23iyWwR5yZnzbUCvNMaMixSGrIyVPB1oghCsOfI4k=;
	b=ul1uefMyYrRpMXkZ1C9SWnqWct9TwUsVpRR2UP/S2UKgwRkBDkgpgi8Jy/JzkVkVsPqb
	 TxuSkOCcPgc3dgBey41q/MYTEyo1voTTltMbPHA1kS2hjW0Eo5AYnnUmXj2ii3W5Ohhww
	 iNSDGEYtW/LMZP1FpBUWw11MlhNB8nhGFk2ylHuq352Zj2e9uKPLFOKDflLUBEbo0aBFg
	 ven0NtH0TEpRWy5ayA4IDUaDBm8/jLRHCMJYDtb+f9VdrRCJWLLL80LGEQ7vqNf56WuvO
	 sQ9jR/RXgMrAbSsfAbRtXwyTqU/QZLhlH0bpgygELdv7uCwDaEWzTUXn9LrEgxC9TKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ui7qLXEe;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A73606A32E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 00:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31A73606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ui7qLXEe
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ccca948203aso2664779a12.3
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 16:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795393278; x=1795998078; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KF23iyWwR5yZnzbUCvNMaMixSGrIyVPB1oghCsOfI4k=;
        b=Ui7qLXEe5JZSNGGNnJt8YRoCIU9BozHUuGdwiGGRpRdbVOmZeySJsVDdurWv9z6VuZ
         VmOigNcxpt4gus56H5t3tfeT+jMthzm64QEJc2zAee84tuc3roRSTwD3Kv0m4dUfr0F+
         4ugqeQMPjbgSS4cdMlpNKVGn/lbd6gTEqFW9TDBlFLcgP5yn4h8g99RzjC8XXY/+LFBY
         IwZpe4ZfiOfxC/PDMkHtsl7/7xATK8AceJkZH0IS98SuaBuBBITDhuqsEsnfsOQEZ/PP
         u3myvmJEKPylm9aDUWQ7+IckA8eVXYDNm+iIKJa0jJHfttZyD/rjsrlkR7z95OGmKQPn
         RqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795393278; x=1795998078;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KF23iyWwR5yZnzbUCvNMaMixSGrIyVPB1oghCsOfI4k=;
        b=B2p2D8XC+DDO07k3a+BlGCkrwhxulls+VYfNhIEkTiOG7ukblANWrYhQ0XbL1DTdgL
         0lC4A+UIcvv6EAvhJyAFUNxblfVZjmRqTWqVxuw09G0qVSJVEv4aOxeTrGPhkAV0lk3M
         QPhD9/lfC/86bcA5YArZKMQmcWCA9oLr6Ibft/Tv5/Xg9aiBiR7LauZuj88zKOWg16Wl
         iAerxBTaeVc8zWS3b/EiR3dlAFge+ch4CJ1sdOePxPoT2Ixh6KqmrhOJhk9RKh6o7XoM
         Tk5OJzyg2xCmb6g2Ey1/bCUZe5PxxErXeAtcL7Wzk36QMF43vcOg0NHv56D0jrQXq0lY
         LFjg==
X-Gm-Message-State: APuU4Z/DMYC8rHX9ePVsa2oziKMzm5TTrH841v3YGFyOVkCdcwLHYMff
	NvxtBicnLSfhPOIId50Cbk1Jjl9zGp+8+ahJifTI4ac/BNvS2y+ile8V
X-Gm-Gg: AZFdTZf6rMwdtUNXcVR+w1JGwRY1hj2xWyMfxH9hzyRD7OE3fgQJPqkQMglOuFWJNtZ
	GWXtDcCIHw96UASU3S16ZUw2gaRtwd2hgulGPu5hD5Tk+pvqLgenAU9+jWKE+SLbdrKysDR3Jpd
	sUuwExC+NGBz7+Sjg51hXuowBTfE7uMfZz+1YCPv8PwD/8aFQoIKNO5WcZrQof57uxVYhiv7Tfs
	AVVglsq4WqYYUhQmxWEuJ/zVgs8gtgY29uIz7Fn3cHSVNnU+iNRqVb2Rx7QVmzZR7Zkrnl0FK5o
	Yzpo94TWU0TFuSjYjGMvenjp8TRU2gzryVsLxWsnKwb7P+XpGR/Fi60GVT+A8YX+dwaYe0be0AW
	61jQFT83MoiU6XJwmNQdy/DYamdGx1yvS49S57OgBQrSHYp0iHpN3zDCRyqA4GZgrq/Pwjl24LS
	jrYUy2tbMgFMpe0Vgzt2NmfnuvS019rP+AB2CaeQ9iivlpHnnyPZS42IcjEkNqp1Hl2uwDnkPQ0
	Ph1icF8tkZTLEpX+G4DH+OmSupwf2TlxNufC7RR65TXPo9w06sGabu5YGEkfcsXQasdkMnGzAH0
	8GN1XIum/HGjunlHPeCCk9kdKZc6zRjdXkZrexbq4Z6iuSRuYNIgVtoIqfMRS6JLRkJ9l8EaV1T
	RfsAIO+21LEQGFCMW2GkJJGZSv0vyDYNpx2U=
X-Received: by 2002:a17:90b:1801:b0:3b0:9984:18c9 with SMTP id 98e67ed59e1d1-3b41c8e16efmr9088622a91.11.1795393278264;
        Sun, 22 Nov 2026 16:21:18 -0800 (PST)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b8733e6sm4860403a91.3.2026.11.22.16.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 16:21:17 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 00:21:16 +0000
Message-Id: <DN25ST0D5K1J.1NI5236BF2BPY@gmail.com>
Cc: <bpf@vger.kernel.org>, <containers@lists.linux.dev>,
 <linux-api@vger.kernel.org>, <linux-arch@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-security-module@vger.kernel.org>, "Aleksa Sarai"
 <aleksa@amutable.com>, "Alexander Mikhalitsyn" <alex@amutable.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Andy Lutomirski"
 <luto@amacapital.net>, "Arnd Bergmann" <arnd@arndb.de>, "Christian Brauner"
 <brauner@kernel.org>, "David Howells" <dhowells@redhat.com>, "Eric Biggers"
 <ebiggers@kernel.org>, "Giuseppe Scrivano" <giuseppe@scrivano.org>, "Hugh
 Dickins" <hughd@google.com>, "Jan Kara" <jack@suse.cz>, "Jeff Layton"
 <jlayton@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Josef Bacik"
 <josef@toxicpanda.com>, "Kees Cook" <kees@kernel.org>, "KP Singh"
 <kpsingh@kernel.org>, "Lennart Poettering" <lennart@poettering.net>, "Neal
 Gompa" <neal@gompa.dev>, "Oleg Nesterov" <oleg@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "Pavel Tikhomirov" <ptikhomirov@virtuozzo.com>,
 "Serge Hallyn" <sergeh@kernel.org>, "Shuah Khan"
 <skhan@linuxfoundation.org>, "Zygmunt Krynicki"
 <zygmunt.krynicki@canonical.com>
Subject: Re: [RFC PATCH v7 00/26] userland: Userland containers
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <20261122193539.3334213-1-jarkko@kernel.org>
References: <20261122193539.3334213-1-jarkko@kernel.org>
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

On Sun, Nov 22, 2026 at 11:35 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> v6: https://lore.kernel.org/linux-fsdevel/20261122011809.2667684-1-jarkko@kernel.org/

v7 was sent 18 hours after v6. v6 got replies from the bots only.
v1 was +2559 lines. v7 is +5782.
All six findings of sashiko on v6 are still in v7.
None of the seven versions got a reply from the vfs or LSM maintainers.

The way you're spamming people you're only reducing chances of anything going in.

