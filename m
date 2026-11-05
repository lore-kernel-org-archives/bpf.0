Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886385;
	b=Bd7T01tQ2go1VjYrZuDDf6lho/VQs80NXE5/YdyA6GhfoDFguiS89w3xVY2jfsk0GCVW
	 +hg4ih4iQ0YBHxqxs7MLTOw0jRbF+0mLWdUsvZbKQBrL+B8srna2AGRtldLsO/PAulHei
	 zrmEfr36ncjXnIWQpIY6AfIljT1sqWHtAJdcHUI0OTZ+YCsRdQK84eBJ12ukt8FTNFeQE
	 AzIOvksnY9zTP0TXNoute8Vr0JPQ8bb1dffVQWSlNrpa+/MkIWc1oA8y5tzl8uRGQ7NB0
	 BgXCr0AjtI4q4qwGNGYUV0SAWgmbOzxm9Xcz+rMwTD9D2Hi/ZT0qjF2oIyx9DF8J0jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sBDq4TRDnfrVVYE/ceW1Z7RewHfol2+wgxiHxq3XLsE=;
	b=bmAOUBGUgXUwxfJUpGiz6hizWRfmOoFDdPDgUJlbSxZx78zA06ckI++BwvFSF/IrAmQr
	 n4P/toQUdtMc28UnPPV3Mft3ZZoXMQzYSYk+gdMTXmOu4sIHWeMrlqKCxkKs+lbf67sWN
	 oZZaVUB1n0jprpowMVYjAkpM6ZTUOSndoxpFJHYtxi7pz/TonvT6Ct1Fl8MhANTZLO+WO
	 Rx2Hr4cZlDJYYuZeWsaW0l0BcjeyFFt95umf9NwLYvqNEB7mFxjhUoQL2ZKVJx5Z18eKH
	 8NrtnXZMdr/JIY3ydbJ4G7HqHy31abb3pNr9Yu8XhXvhxDegqAjM53QwFlJFVg9OCwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lflW0hba;
	arc=none smtp.remote-ip=209.85.221.182
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D61606A328
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 13:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2D61606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lflW0hba
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5eac319a6c2so675319e0c.0
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 05:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793886384; x=1794491184; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sBDq4TRDnfrVVYE/ceW1Z7RewHfol2+wgxiHxq3XLsE=;
        b=lflW0hbaoLI7rDVMCFMrBILrzso6kQHXL7fzsEp89MQdXWgOJXskAVAP4Y2NY2uZFR
         TJytWakEPHg+zTLapuQPh6CxZMeUYx77pQLj6ERCkO2WrPpMLrTNA+G2JIojjWgaYnBd
         bj/1BTi/sJzwmJp9jr8i2tN2Uos2Jz9Q3pOyocQbKXfRRZo4ZdCv5yJfp3DPcSHUpJB0
         abXiqtuothrBd5HydbCdQ3vudqkjFvhlAOpkkgEk8eGr5kQHOLC1H60ptD1DbbCyEHgE
         E9UfiK0ow0IBLAaavpf9zcFgrjx/P2/nplaWZiOoXU781jXzEGYiaI5UunS70wYdf+WU
         mX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793886384; x=1794491184;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sBDq4TRDnfrVVYE/ceW1Z7RewHfol2+wgxiHxq3XLsE=;
        b=UnYNlfNvgOyxly4bBcBqs1YBAqX+zvXNDZllrZtelnw81KB2B1hcGJfNObCSS1mD2D
         71GQuYNUjXXSg58FkZ4YgDSFoCJMIraHT5GKm05572RrxY2OWocG8F/jIM+ItuaHQe0K
         Dy9VsxQQ1VN4u4otscrCHtIr+sRShBvYABa8zsukrRVzUJM2+u3XLFekfTpl5gKv4T7R
         0D82NNfoVC5oS9nJIYlT+QxZKjiGliB5X32J5IIA7kLNTjbtlldE+KU8R+EfJXHJNofg
         zwnfivFG2WFRGQfzKmaOI2ao3STO8pVpPNcOG8NgpBxhxTscq/w85DZZeBPX+4cTPxnQ
         iVeQ==
X-Forwarded-Encrypted: i=1; AKwUvBwSTDNLf44DDxzgvZyzz7+x5f6B0ZKHnvg/5rs3k4zOXm03R9bZPhhdg9LfNvcZOqzWnZQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8rzWR5su4IXeXv0l9PU39vjYNPPDVF/M2pw9WPxiSB35KlA1Yr
	lJt0n3MzmAPqKom6NPSVmd/S2EjJa+g+/FOg5+0gv/0O0SHIMnTxbZt0
X-Gm-Gg: AYBFou2RK5jfW0Sx0sCbo+5mcktGdaV+BwcCVwqAhZEKH2WfQq/vdeDb+q/UIRze/Ii
	R11NyKKKFFARKTL+lorCG/VHdTV8owOHwxEhYABIMN5bMpnH7i8E7WKmkrEgXhtMZQ1gjhEwHCn
	xMmK1gsUjuBgR2XLckTyK4eNw0vf5uVTK8CR/h7SgMUJH4ne+mXZSlXdw/GppKqadPvDbD+koH1
	ry8LF/BZveuwTi/Md8pb26bcUBc+NvX79i7XexS5cJq9rQXl/+EXLbhh/HeGU+ZSMXDU9KJMyet
	jaHn90rmHRNfTKvweU1JkiN44zEhVj2MrJC21bXJ5zlXYvPNg2b2v0m+evlyR03LpzeEM2PNhzP
	/uN3gAFmhDgcf+MMuhK+cmefVv7it0ic3xdFforNTs1wILp70Im+gyZ33aejIPcTqQkCS9AHTBx
	1LI+N5xURKEfg0oSUCtGiD94v83BOrPNBFLHNdg3gc7TYiRx5xJugVa1ZgByNxbaAIYxLCzqzY0
	0veggZm7F/09oQUj4IDf7wMRLp6ZRWvIl/bzftS9M9+OzYc2sPrbz00FufA6foePZ9SoNcVaF20
	OxwTY4pDWYJXxYOFGsSMxIzVaavZnIiqdoGgKm2g99oJs3er/oIHGG/xJgftpkd4QJwCtXS91qC
	cJqGII9U9mw/hRPv7XMBKMx2AUyMAAJhNmnjgGYzeyhlwKO6lQBrr4NxCF+gCDMUiByERKPU=
X-Received: by 2002:a05:6102:8092:b0:7cc:56a:58d3 with SMTP id ada2fe7eead31-7d07279cd1amr9349602137.31.1793886383896;
        Thu, 05 Nov 2026 05:46:23 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8da73e8sm4230200e0c.10.2026.11.05.05.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 05:46:23 -0800 (PST)
Date: Thu, 05 Nov 2026 08:46:22 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 bpf@vger.kernel.org, 
 dsahern@kernel.org, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.213e1d84478e4@gmail.com>
In-Reply-To: <20261105143049.51af15a1@stephen-xps.local>
References: <20261103033611.949104-1-willemdebruijn.kernel@gmail.com>
 <20261103092226.2e8ab229@stephen-xps.local>
 <willemdebruijn.kernel.a20ae72714a7@gmail.com>
 <20261105143049.51af15a1@stephen-xps.local>
Subject: Re: [PATCH net-next] docs: netdev: fix iproute2 process documentation
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Stephen Hemminger wrote:
> On Tue, 03 Nov 2026 09:44:53 -0500
> Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> 
> > Stephen Hemminger wrote:
> > > On Mon,  2 Nov 2026 22:35:56 -0500
> > > Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> > >   
> > > > +
> > > > +Patches are tracked in patchwork under the netdevbpf project and delegated
> > > > +to 'shemminger' for further processing:
> > > > +  
> > > 
> > > Minor nit. David Ahern (dsa) handles the iproute-next patches.
> > > I stick to only iproute.   
> > 
> > I know, but there is no separate delegation in patchwork to David.
> > 
> > I assumed all iproute2 patches would get delegated to your patchwork
> > component. Is this not correct?
> 
> Right now we correct it manually. Often patches target the wrong tree.

This is not about the trees, but delegate on patchwork. There is no
delegate dsahern in the dropdown menu.



