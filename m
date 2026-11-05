Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793857459;
	b=cjywq50Ug2iiOtCZ3KkpiDfQXWyTveXI0I5YHGp3RlSbC7zDJyOkqBtS/GERYvNCQ+E1
	 PA5z13mZCLj+ezeE00qNr201a01kLRpYScMS0aHvWxAlp2HMD5Ju0lkx8vIgdetF/v3oQ
	 F1W9xLTSSqPQnv+tXlZEXBwoaW3oOAhi0NeVHhUqePiuRL1NxkTKkOXIIDMW4HhWJ7R4O
	 UkHORVX7kg8b1/88ljURTG/+f943ZWxUbhBc5lLN3mSp7YlzKiAql8NdUdwcNg6Ka58Oc
	 XCn4tyBDzLn9AS/8n8xFD1S9SUfByiFWTLa5Qri82D3y+AagW+gRdIliEG+7a0dcUGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793857459;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=OeDkQPQERL1IHJch5/LqOTn8ma8MQ8l46JedvJ/kKt3pWfQqItrqoV/AcuK7/I6CvZNO
	 0BE/kbjFzOgvELwFDgFP2rsrF88ibvEP9nqL9rwEWU077CfcWUnnG/k9tPoPIQnYQzj5+
	 J+OsdSXnPNb6o2yl3bAhSJ+0Apy5ZKZSqMm8g5IcQ/NSSONWY1oNOlTg6260mX0xH90q2
	 QcGd/KWI0jOnJsApPWyyTcu0Pki9igu/FMX8/oLuL7yjfAv+gIE7THiiCvy8eiWPMoDHT
	 E6s/2jq8Nz8mJpUY8O+Hoy5FCAUyJe5Up6meUPzixI+yc626KMv1WeO/p71BxXRpIeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ssgp8SBv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9FB606A31B;
	Thu,  5 Nov 2026 05:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ssgp8SBv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6581F000C1;
	Thu,  5 Nov 2026 05:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793857458;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ssgp8SBvXBQddBD2jD9EpGEOfPT1JS9gifrz8qeuurJw3+MdiE3RzGB3jCQJACkf4
	 s3+v9ZRC7T1g1VjrcBcCHg9pYWZJRMMk+nmHqhr/SIpSvtkZt5G7aU72sqHWF0k9bX
	 MPAKLtGhY6AY+Ev0Okb88CtKbuGCxRturKr6o6vwvN6WChnp5BN/OoxGZT8W7gJBQz
	 Xu8sMv5D4rsaTaUNBiA/cRSOMNDlwA05+f9T7AplIrhw6XX4Th6d0aZR2uUs1CFIBm
	 lwwNcaYpuGaVzxsSAAVO/8iafCU8gDCm2OpMsOqx6Fs/B8JuRJOyuPzHZATG51RXE8
	 qzQVgV/FhMJUw==
From: netdev-bot+sinfo@kernel.org
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: netdev@vger.kernel.org, kuba@kernel.org, maxime.chevallier@bootlin.com,
 ansuelsmth@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 faizal.abdul.rahim@intel.com, noor.azura.ahmad.tarmizi@intel.com,
 yoong.siang.song@intel.com, rohan.g.thomas@altera.com,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH net v2] net: stmmac: Disable queues before
 netif_tx_disable in xdp_release
Date: Thu, 05 Nov 2026 05:44:16 +0000
Message-ID: <179385745676.488859.15047270659834143749@kernel.org>
In-Reply-To:
 <20261105053916.22353-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References:
 <20261105053916.22353-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
