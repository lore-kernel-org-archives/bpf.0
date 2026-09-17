Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3CA53F6BE
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 17:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664925; cv=none; b=sa12/JlCwORZsEmY5dJI231wJXrEisOTrUORlgSbXHahroBmJoprLu4CRw9ucXqCDELjFoaA4/wlETqpwhckgyGDCWpqSLMpmmL4kZvWFX+3N8xpHpjiBqjMxWMIjzpReIfJWnGZ4n0+Ya+NCguKgO5WJmJjX8gbKVx0WWupzMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664925; c=relaxed/simple;
	bh=ezE7e+8hPeD6bknEPOWbSDt55vcUmx1NSW5YZif6bkw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DEGs1L5kdotfDzxGPiOZPRFOQSa4NOPE+ZnmWf6BNsA+wREqXDLjRVNu+U8Gk8lds4qjXUAo7u2h/vNyQ2UgV25+p5qiVoF9ke/fcIxPfK3W3f0jE/w2AvSJypojvj3YhDNsGbWuwTeXaziZlwYqiH9jw98/h8fvuDNAl71UhPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVuYxTvN; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVuYxTvN"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1ceb47d53so209622a12.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 10:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789664923; x=1790269723; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ezE7e+8hPeD6bknEPOWbSDt55vcUmx1NSW5YZif6bkw=;
        b=iVuYxTvNLMPjMAfCW0j0FNuCl+bP66PzxM1D8pkhlu1zOCzoAwveE2Us06+t+lejrl
         U5wg8NxNiGf5QlOwIvTLXv4a//VHwxWfxCPhiurnZ6vBmPdvfMolH/PWDtbF6TCJOqi2
         44aZWQNYE/YrlW0rq8dbgX56SbYAhFCMahUnZgXl5dDLyP0S7zRojFPDP2BWMT56Upcl
         YRSacQvl3TzEjo1yPvbd1YveNaDKieB3p9GI/forJur2LMwo/Smr8Ax3uI3qEzEAJ21G
         D4BbKbFsLiln5668FLJwWTT34JuzyB5fIMmqZ/Zb6ytdtm6D6HRIxzchRqxnwoQFLUwD
         6jWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789664923; x=1790269723;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ezE7e+8hPeD6bknEPOWbSDt55vcUmx1NSW5YZif6bkw=;
        b=HfHgDQKjKfXAvznCaUmoKjofFtGltWZ4dApntCyhXUU95YTzRUKB+MKo+JRveyUzAb
         OfqtbhEPLtjOqhk6JLwqykWKzh9IjwB+OTxJX8qy7wqJABBT5CNeiNX9Q/+EiPDnOWVd
         KsQ7wDr2Sl4qhPjaWozLjGDXN7gAnu7Se07YezWj2hsPDuvsH1IJxLi2Sd2KAPQsEP9Q
         gGWVpeyoJwVJYrRrPYO+vaMXQAElz+H8mcfDQUGxYt2jLbRJaOgV50xBqOPGW74PJxsW
         FMJ7UbSImg69FvlxJOi3kTYI3HCOY5Ehkk8W8f4RTyzy9tGQcG0KBLzgJiJdejPa0gfr
         kJrg==
X-Forwarded-Encrypted: i=1; AKwUvBzTGq0G94lTd8S4A/GNN9zWvieKqdZOChZbJdBK3MURvrs1fGjb7SCW3ee2hs2CnUUEIZQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mb2KXT/S8p3bDhr9nv40c99NICvH5u+4nJPltBrhyP23nX48zm
	ZfqUoyoqYi0qnGQ+x/zXNohpRy2tbwGcTNOdkB50YdRxlTg5qLImxkyy
X-Gm-Gg: AYBFou1SEoxQAv5rxl5gZUZb+VSYvlXU5f8a/hsSyj/dNF3p6CUHJhDs/+TijA2pvHp
	ssWXb+JQ9uYJ3Dbkja29upThq89l4B6pnSS31BIybUS55c/qIqBkTN/wVwr2CwAlIrzOejAtYAT
	rS/xCQHXGro9dsbZYedELuuQrZg2jSPHlyMhBY1eRtienEctBgVhQR08yMW2z8/3cGkYpIA/3H4
	pp2hmPlhpd6f3qbzFXS5YEoqYfrDVktxnUYKoWFSG+iOEqeO0XGTb2cfRyJaIG6WJIPayjcfPET
	5xMp5nm0B+9emxuC3Y0H5curXkkpGEEtPL9Nb8N1o8VB/om/E9r/a7tKJsO8bZTp+z6epHXpM8a
	5BzfujvDQx7jp80nja0HTmStvM8wqfQj8W8kAHk5g6g8G2ejvP2PwVtP7gaU1PHxE2Dtf6ExfG4
	HV08od4LC2YLdggqqBd/30iG7zeeDx5lk56UZ8L2Ki1qHiiR0cWrzGc3Nm6WmaJsV2AunKnWKVV
	Bz2w8uSCaobB4hLXVZeHhIk/xAR
X-Received: by 2002:a17:90b:2c87:b0:39e:4c7e:bc6 with SMTP id 98e67ed59e1d1-39e4c7e0e37mr1026900a91.20.1789664922555;
        Thu, 17 Sep 2026 10:08:42 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e361b7266sm6066044a91.13.2026.09.17.10.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 10:08:42 -0700 (PDT)
Message-ID: <c80c4e2aee9502d781fb52bcd5c0972ccd3bc7e4.camel@gmail.com>
Subject: Re: Missing signoff in the bpf tree
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mark Brown <broonie@kernel.org>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, bpf
 <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, 
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Date: Thu, 17 Sep 2026 10:08:38 -0700
In-Reply-To: <9d668d7c-8f85-49ad-bdb9-5cb81fb6f60d@sirena.org.uk>
References: <aqvBPVcN__UX8P85@sirena.org.uk>
	 <DLHJEZ0K0FV1.SCQLJJQNS1ES@gmail.com>
	 <66d3f5cd-12df-4000-8459-360ba57cea12@sirena.org.uk>
	 <DLHJUSTDSQ05.28VUGOV7YPS6V@gmail.com>
	 <ec2acd16-40e3-46b7-b120-ce9eec70e942@sirena.org.uk>
	 <DLHK013DCY3J.19Y8X3Z0RTWCI@gmail.com>
	 <9d668d7c-8f85-49ad-bdb9-5cb81fb6f60d@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-09-17 at 16:03 +0100, Mark Brown wrote:
> On Thu, Sep 17, 2026 at 01:27:01PM +0200, Kumar Kartikeya Dwivedi wrote:
> > On Thu Sep 17, 2026 at 1:23 PM CEST, Mark Brown wrote:
>=20
> > > Do you have a full list of the current committers, I guess there's be=
en
> > > more bitrot than just this?
>=20
> > It's me and Eduard, apart from Alexei, Daniel, and Andrii.
>=20
> I've added you and Eduard.

Apologies, that's on me, some issue with scripts configuration again.
What would you like me to do? Force push with SOBs?
