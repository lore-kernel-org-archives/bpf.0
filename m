Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B014749E9
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791368428; cv=none; b=W6s/Ez3+5+q8+liqESdirdWKhUoMZN9ISwl+2cOVmg8iDPNZQahdDO6yGuf/86LAVVQdV/xvAGnR39ZfrCYkKdH92vzvqHzuG1OqqYkmGVNWrygbBMspJvX/yv8Yf1JhlcpC9ecIOKQJbdysyJ+5esI924Fhtj2dTZ62EXMKgWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791368428; c=relaxed/simple;
	bh=rFAvUO4Y/vcYHM1X2jKNJMuKbU0DG4p6en3YHWz9DUE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S7c9gH2kBjrR7IEUQ+6uHDXgPXKatwXuF/0mRM06Gcm5bjygFSZZdaLrxneF2O7RzfgJJa0+pjBwq6p2lq04g2khMCKwz54w1sSslud3r/G7lOlQNpITNVfQpdFPEBt7BozqYTt9Hrz2+xOIsQyY4G+SxBYa4/g/0x7y8VFOZkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h8giNJUB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jy9wEEPh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h8giNJUB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jy9wEEPh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791368419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFAvUO4Y/vcYHM1X2jKNJMuKbU0DG4p6en3YHWz9DUE=;
	b=h8giNJUBhVEGNxmVHQEdH54c/XlTcssKwhioOE5d/U1cAyDY4GxPGceWzDr8Ky+3iYD0/5
	MOYJspt8dxLVLdZVq78zvm5eCLD9+pqIbfpO826e6jp84ckILBYAbEsBbq1xNORsFUP+Xh
	QehnUMnGMevch55qTkF86cWZzl+ga7A=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-EL9lNuY5P--f6Kdo9rUuDw-1; Wed, 07 Oct 2026 06:20:18 -0400
X-MC-Unique: EL9lNuY5P--f6Kdo9rUuDw-1
X-Mimecast-MFC-AGG-ID: EL9lNuY5P--f6Kdo9rUuDw_1791368417
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c2e41c60b42so269641066b.0
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 03:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791368417; x=1791973217; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rFAvUO4Y/vcYHM1X2jKNJMuKbU0DG4p6en3YHWz9DUE=;
        b=Jy9wEEPhwMeUmcZ30M+B2K96pMC9WI6L7uHAEjEAwj0swcHEWs7CK7QdKicyqVvdB4
         2V/dF5LfbrEDP1nAOdQOLQxAaAHd9b9G3DzSa8FzjxpGVM59No+cHmbfvYSAkZoFh69k
         XzTe8K6y6fns9egJyTOUn+9FSDUfgVWWymeF6tXJIZi5VhWfSPYvunB1GJux7+1wGgKS
         QccKXwWqreY+4ulNQkzj1GR8DeuGHsAde4VYJ5h4FOsDh1kpgKWlE0z6LYyX/nLh3Y8r
         FIz9+4v7jZVDZrFisTLZs0fw8nfxE6v1qK7qRZb5HVSqQhWi1pnxv3kFCacAOsAg4A5D
         mTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791368417; x=1791973217;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rFAvUO4Y/vcYHM1X2jKNJMuKbU0DG4p6en3YHWz9DUE=;
        b=EtjcoAcw7Ot+2V4BIW/pC3oVlPp9t/8vDhOwcy9z7zTJv3oFS/gWC/Cr1BN0GV+w0X
         9B/nKHkoc0LdY/jISODMKU4BQJi9+UEXgkRRFihMrI8OxpTU7tiKKsLPZKs51fwMwiTr
         vJLfbPyVlUCxl7mhg8QPWv9QvHbwB7NUtp2dqSeh+FNjUfd3zmvj9IzCRouw8jml1zww
         FZXFoQWG32bHe0goJO6jvTqsd/AFEhKnifkAWt+C2x/kER+8WurE7uqZo4T+ykTExP04
         dQ9UHqzV4CL9+RHgNpgNEXgar7Ma3a6G0ohrcuQdbFVk+nm59W6fOvHUYlN7BHBtAhtz
         LzoQ==
X-Forwarded-Encrypted: i=1; AKwUvBxV9cSqwjL6LqguB6+r/VM3fAOx2P1cve8DuYw1Lg6hqxagVKfeTqth3dH28FyK6qQ5KII=@vger.kernel.org
X-Gm-Message-State: AFuF++k412CkRfdBGd5lKt9kvZ0+DR9DpiuRN5VadOkvHFguTkZ4guum
	dFlZuhhldNpn9p4SGKuJmapZU//h5u8Ws/FvMEQxclDxZQ83T1GVg/pDimaiLdLtZ1lVrIMLvV0
	5LklSpfnBGD0xa+bCFIJljomm3SjTJm11hTmx7C/qRy5ddeKZ2sbRvA==
X-Gm-Gg: AYBFou1he7FKtbQJY2vS7YsxwJ6aTbADt7bepLrd8V93kJ3SfEjIrijLd4BT1OqMJPA
	28V07RCVHNfDu2aVYYBp/3cSYoJrz7pPAXKVUPQFadmyJluqNW5DQup7zzleFh71RFBc1igPPph
	SFaW70rblnBe5+LkN+t2mgh9oi4AVOjTyR1pGimieQsc9Vos9Qct4APF6TrUiAX+maXQl5kne09
	Hjx/u496ku7FjoDZuJSxE6Ysmk+4na0nsUtB0aCmhyZ9X8WUztbjeVB2nRknqVDB67PigEaJ0Hn
	GCEQg6JMGr4zGIlSvsQVH+3lSgRkRkjze4EYZ1maWETcGhxrA2qr7cEDlXoHklnMHHk5V9em6C0
	HgnS7WvG1zdh3Q6MM8FomuVTi
X-Received: by 2002:a17:906:f592:b0:c29:d31f:7d6a with SMTP id a640c23a62f3a-c317bf67d52mr155718466b.35.1791368416958;
        Wed, 07 Oct 2026 03:20:16 -0700 (PDT)
X-Received: by 2002:a17:906:f592:b0:c29:d31f:7d6a with SMTP id a640c23a62f3a-c317bf67d52mr155715166b.35.1791368416617;
        Wed, 07 Oct 2026 03:20:16 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c317c32af4fsm81250166b.63.2026.10.07.03.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 03:20:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D29F7A4CB6C; Wed, 07 Oct 2026 12:20:13 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Tianyi Gao <tianyi@cloudflare.com>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, lorenzo@kernel.org, horms@kernel.org,
 bpf@vger.kernel.org, shuah@kernel.org, hawk@kernel.org,
 kernel-team@cloudflare.com, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, sdf@fomichev.me,
 linux-kselftest@vger.kernel.org, Tianyi Gao <tianyi@cloudflare.com>
Subject: Re: [PATCH net 1/2] veth: fix peer NETDEV_XDP_ACT_NDO_XMIT after
 GRO is toggled while down
In-Reply-To: <20261006173241.65945-2-tianyi@cloudflare.com>
References: <20261006173241.65945-1-tianyi@cloudflare.com>
 <20261006173241.65945-2-tianyi@cloudflare.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 07 Oct 2026 12:20:13 +0200
Message-ID: <87cxtlu80y.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Tianyi Gao <tianyi@cloudflare.com> writes:

> A veth device advertises NETDEV_XDP_ACT_NDO_XMIT only if its peer has an
> XDP program attached or GRO enabled, that is, only if the peer will have
> NAPI to receive the frames.
>
> veth_set_features() updates the peer's flag when GRO is toggled, but
> returns early if the device is down, and veth_open() only refreshes the
> flags of the device being opened. Toggling GRO while the device is down
> therefore leaves the peer's flag stale after the device comes up.
>
> If GRO was enabled while down, the device comes up with NAPI but the
> peer does not advertise NDO_XMIT, and devmap rejects redirects to the
> peer with -EOPNOTSUPP. If GRO was disabled while down, the device comes
> up without NAPI but the peer still advertises NDO_XMIT, so redirects are
> accepted and then dropped in veth_xdp_xmit() with -ENXIO.
>
> Commit 7a6102aa6df0 ("veth: Update XDP feature set when bringing up
> device") made veth_open() refresh the device's own flags. Refresh the
> peer's flags there too. The peer's flag depends on this device's XDP
> program and GRO setting, not on whether the peer is up, so it is
> correct to set it even if the peer is down.
>
> Fixes: 8267fc71abb2 ("veth: take into account peer device for NETDEV_XDP_=
ACT_NDO_XMIT xdp_features flag")
> Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

