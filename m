Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795613982;
	b=gPSswqrunJ+Bg6TcYrp6Zy5C9EDa1lvUt5hVpRElgHmvTPdZQ/wE2P5Ezv9rKsjx9SDW
	 jMj80V1QJi7dvdTD2Nl/OSXx0On482Oh9rD4xJiB9eJtEtVhBn2At+YIA77l3J63xBbPe
	 hnx3UTHj7PodfISeD8/XDlLIoW5dXO4CxptSsfcijV/vmW1OnhCR/2STMoa4z3g+m4PaG
	 bYDzF2+wC/qfQDekWICOmnx4RAC3fQMb+pVoyQtaGd3psWBdrkI4iZ26sulfjRXaxXnWg
	 W1vUsqnYyExLSvET3t7GtUZ1ro5G/OtnObw71bySK6sFsrJmaMbimoVo3JDuPISUodA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795613982;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=k0XLbZ5M9INRCrfgtQEgGkLYc24AmJcFIXjSp0f6z04=;
	b=2b12Sa2yjAXg6ixz0cMg4cLegvrBwEvyqP02ztE1ONaGYYjPM56Emq5/D0A/lkT4S2IF
	 wR9gZDX41VULVvRtaNYTclLwMssbwkDGHotDX355JK7/LsoDsc+i+odMciWJTXybapLgy
	 S8sIerh0+wcOYDO75CteDexAjyIhbWoFsXvWrWiwxBPSnZzm//ZUk6dm/YeJfNOOSnFzh
	 6+Yiu0lGW10lMMK0DerMynzQX7rNAiPTQo3kyXJLyC6pa8ulZBBrmH9QkuFn1FQZnJTNi
	 ZKyHTekMgdM3vrcpy01Znw/nznqayfAYl6JFezJdlASnLwdB4vmT4pg+cUTTkJzPmsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=b8jVcM96;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE45606A321
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 13:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AE45606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=b8jVcM96
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c516a194350so55975166b.3
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 05:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1795613980; x=1796218780; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k0XLbZ5M9INRCrfgtQEgGkLYc24AmJcFIXjSp0f6z04=;
        b=b8jVcM96WIRlFvvBHc3+t3GHIXAgTbrYHlwqEgANzhaRJM8KHUJQGkjKek2GweDfkK
         fWV46dAdq6qkDaSKG3wQCsGoLgw3QsPLD624iaVSbQzlJeVXVxU+hR2CjAhXGCY9IZO4
         YnOJID7TPw7IBqn0ckWnQzsQSW80ryS+x7JM6O2zCJ+1NlsxbhENIrSYBd+Lkoekexk4
         GJZtkmyE61wklfzreOoyMUTIoq9C7cmJbH/JPb4ltHO0SgxUlaz+A7BixBhOD2SsI0pd
         ti9mEfop5VOVc6MT3VnnGwZoJBzkfX8iAPcQwi0iu1oGEV+8dst2R3P+f73hPETqBqMl
         i9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795613980; x=1796218780;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k0XLbZ5M9INRCrfgtQEgGkLYc24AmJcFIXjSp0f6z04=;
        b=ppO2dPO0b9h6ZDmlwvKa4BdHTw1JmtDr8JNgJnIHFeV1RXoF0Tp/fWOjXuLltuXi+H
         UMggGZ1Hjnlk2CJpf4RzhvBZXmNo4CnuBSXtZYZUhVmdQGP3iuhLZMtz38MB0dnV6h4J
         91BGjirBHLhfVzK1NBitF9r5zEM4KIndHILhS92UIwgYW/5mRZngwrIWtX8lwTjO8vtB
         WihHxTzmJoFyrdh/BqmmXX+n6ejGhfvCYOUPlyaNlRhguclmyd0L5zOsTKr/KFbJ9Hmz
         8c/y+ch2IDBvo/2UvLUfMovr9Bkc9kEpBfmhY8x4PycqQig+aQ1RuV9jIoiUcIds5/1/
         N6HQ==
X-Forwarded-Encrypted: i=1; AL+hErFaUgRLYncRnnPUZc5KQKZrRzKuEFq7C336YIu1XIs7QvHdW2V4IBcwUWgG4iZY3gVWhHI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Zb/bs+Br5LdL8K7WJLWJoIhZaJh/6xZNfrBhtZjkUzwyZ6gz5
	A+K2/OORpBc+Ca8xwqSZXoth4zI2LLaQ4Sc/zB8JUvfagWyosR7ibdkltxTM+tThUv0=
X-Gm-Gg: AZFdTZer/kemZPgoZzus+5q7ASvdYp+uX1t6WmwkWwaJ2cMQnZ3Jl7lnPVcGBKa9aPE
	ehGaDiXJImLszamyAkh5hHLqIR2RPJK91zeuxmaQqYBQOK0Qy0qOUvpwZmY77+4UndCchRiqZG8
	1Z0TEKnLlmlEH4iB/WJQ4LtZwNHzJL6NqUfMzCOBq+tPdRD2XHpWnqMp/aDpOPcbrn1TzJqHWUR
	aApcGDcCasA4YdrdGpDLIgbq6xifdcKxG2mGUaCYe/bQammcN1k6o2YbR3txa/kLky2cgI8LUpe
	Ixhtz6X101SyCFYg/RH9JNuEq94yU/6U1z56diS4Kep/quX3vIfXTY7IXy+aRVVaiZYPSFS0sEJ
	OLq64fFZOseBgQv7tLSeYN5GiXhr1cL8vibTgIDBxZ6D2I7hQkMGKzN/w8/4EvOB+pbnsPF8q2F
	us08LkhEHGNZO9syEXOcB3Dxdqaer7ymVAL58XdMY5R7NiPfewR6ddDXw29tfCbr2olmDIYE8hP
	jri4/AJf3Lk4yJod95VhJS7ZOHhDjYffHsWW7FFb/iCb3Cv9TrHfA2Fo+ACif01/E13XKQRxQtg
	I+ss2cmOUANidf7bIDgCxGhl+Ea4Wcq3/tO+/56vbWsCKzU=
X-Received: by 2002:a17:907:6ea9:b0:c46:a5bb:5740 with SMTP id a640c23a62f3a-c513a3a656cmr1605152966b.5.1795613980473;
        Wed, 25 Nov 2026 05:39:40 -0800 (PST)
Received: from L9JK9NPFH9 ([2a09:bac6:37ad:1e5a::306:5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae679e3sm637401166b.22.2026.11.25.05.39.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 05:39:40 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Alice Michael <alice.michael@intel.com>,
	Eric Joyner <eric.joyner@intel.com>,
	Jesse Brandeburg <jbrandeb@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	bpf@vger.kernel.org,
	kernel-team@cloudflare.com,
	tianyi.gao@linux.dev
Subject: Re: [PATCH net v2] ice: do not report CHECKSUM_COMPLETE when an XDP program is attached
Date: Wed, 25 Nov 2026 13:39:35 +0000
Message-ID: <20261125133935.36695-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <awbGK9v4k3Fh4U+H@boxer>
References: <20261125095201.98279-1-tianyi@cloudflare.com> <awbGK9v4k3Fh4U+H@boxer>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

On Wed, 2026-11-25 at 12:27 +0100, Maciej Fijalkowski wrote:
> My ack was meant to say: let us get the behavior aligned to mlx5 and given
> that there is pending work regarding checksum capabilities in XDP,
> Alexander's concerns are meant to be addressed at -next kernel candidates.

Thanks for clarifying, and sorry for dropping it. I was not sure if the
ack still applied after the change moved to the control path. The
behavior in v2 is the same as in v1, aligned to mlx5. If you are fine
with v2, could you send your Acked-by again, or could I just bring it
back if there is a v3?

> If code has changed *so much* why have you kept the Suggested-by tag from
> Jesse?

The Suggested-by tag is mainly about what to fix rather than the code.
But Jesse and I also discussed the code itself before I sent v1 and v2,
so I kept it.

Thanks,
Tianyi
