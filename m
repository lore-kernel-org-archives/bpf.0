Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.31
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795353660;
	b=t9Oz0SXsEdk/mP7dsUgqid1cBVmfo3Y6Z4udxWCMDlys/5h7dI8yCS/L47R/udh9E7pG
	 Geqwg8GxpjkzoJ/o1jxY/H2t6CGRW8Q/5aZJJ8BGosbtzrERHiT8IFDVJCoTXwxvOaD4w
	 qOSLY7ODmJ9dj44bc+YQAi+Dvcxu/cU1rO2K1eQPb510Ck7B7GDu04CsLIGIIuGNz+5HD
	 j/MOTrEIwD94VCe2Lv6gCIRHk5ers13R1J0/ueRr78cTSOp3g+IwatL/VTstP6qfH/x9X
	 xtruPfN/s4aPDHjvEfiv5eBPlm0Ro4xTe0yly0Pj72OxS7DRG1VCjjpN7C2PlfyzVwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795353660;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=eoP3hjAwq4Cw4bE/mFqEl7hyxh+jDCjYeuZjTBgdVoA=;
	b=tCfuyY3ofTgeed6d55EN1WlvsMD+WPjfdpRAvM9IT8C+RYKAjrZoRzYZ1zAIWFB+omJa
	 8OfPB8UTQnBgeNzRG/DRyrrKSGLVq1FFr9t++Uh8SG+7Di+U4nQDMNSdIHYCCixv6fXXk
	 cQjoOls0XCJl0ktAXcEUjTkDSOpRN4eOHCs8lBUQN4ZBruYS19dkc+VnWN9gTH7KbdJ8S
	 9hLZ7BCY0TGtTJsSavFRHPmSuTQTdbvBvUYIUbH+GuwO+hKh4tqI9hoWPNMY1O6zKnFFO
	 Cd8t9F5v+wl1r6WbP5UtRFjje+lu0zubrDQiIEefcflSWEeUXYzoKbAlntb2vn+vBHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=rpoke7kI;
	arc=none smtp.remote-ip=79.135.106.31
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82E4606A32C;
	Sun, 22 Nov 2026 13:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E82E4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=rpoke7kI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1795353654; x=1795612854;
	bh=eoP3hjAwq4Cw4bE/mFqEl7hyxh+jDCjYeuZjTBgdVoA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=rpoke7kIbufv5EUE+v6QP9RKHaLv9d1qKHGkUFy0dbwBonBukYa4BaGXbmrm8WNVk
	 m3uZZVey1t5mFukibLbam0SOEw8fBIt9sylsw0uynTm0vxf+RwueirbLJyiaScBMAl
	 HVux3Ir16vSZ+lRQkEZ6T7U23zaAoORLPgu+3vJEFhv6hHMyWEOLoQMbvKLOLikTzQ
	 LNmBXVTBRkdMVelcTB6RDEZpUzWwV3HA6hxJ+jdK7l8ie/oa6t1e6mvHjCFdz0J90y
	 Ut6Rj2s11nbcT9bZcjbP5JHte8w3FaHTm9YqSHy9So6y5/tbfcchZf+3aj+EubmQJ+
	 XmD2bDeMu9Eew==
Date: Sun, 22 Nov 2026 13:20:46 +0000
To: Tjerk Kusters <tkusters@aweta.nl>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Sven Auhagen <sven.auhagen@voleatech.de>, Richard Cochran <richardcochran@gmail.com>, Kurt Kanzenbach <kurt@linutronix.de>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
From: Tore Sinding Bekkedal <toresbe@protonmail.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Paul Moses <p@1g4.org>, stable@vger.kernel.org, Piotr Kwapulinski <piotr.kwapulinski@intel.com>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Alexander Nowlin <alexander.nowlin@intel.com>
Subject: Re: [PATCH net v7 2/3] igb: only strip Rx timestamp header on the first buffer of a frame
Message-ID: <d1cec124-8685-4be9-ae70-1142e3be4f88@protonmail.com>
In-Reply-To: <20261120-igb-rx-ts-fix-v7-2-63b03045978e@aweta.nl>
References: <20261120-igb-rx-ts-fix-v7-0-63b03045978e@aweta.nl> <20261120-igb-rx-ts-fix-v7-2-63b03045978e@aweta.nl>
Feedback-ID: 21125876:user:proton
X-Pm-Message-ID: 687ed69b38c3864e14592e27266a6843882b0919
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/20/26 12:10 PM, Tjerk Kusters wrote:
> This is easily triggered by a GigE Vision camera streaming dark frames
> (mostly 0x00 pixel data) over jumbo UDP with PTP active on the receiver:
Mostly commenting to make this thread searchable -
We ran into it on a Ceph cluster: Proxmox VE hosts (kernel
6.14.8-2-pve) with Intel I350 ports in an LACP bond at MTU 9000.

Enabling chrony's "hwtimestamp *" put the ports in HWTSTAMP_FILTER_ALL,=20
after which jumbo frames arrived 32 bytes short (tcpdump: "total length=20
9000 > length 8968") and were dropped. Small packets were unaffected, so=20
  Ceph heartbeats kept passing while OSD traffic stalled, reporting=20
laggy PGs and slow ops.

Note that removing hwtimestamp from chrony.conf and restarting chrony=20
did not clear it; the ports stayed in HWTSTAMP_FILTER_ALL (using ethtool=20
-T") until the filter was explicitly set back to NONE.

Thanks for the fix.

