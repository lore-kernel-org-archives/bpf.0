Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793538463;
	b=gPrGpMS3CfDodRXDGeHQC38bcxog1bXtbv9k6VHTbDxuUBZJFXWoYN3/nOVM9HnYEvDF
	 2M42PiMA9R8Ccyy3W/+fC4ZcoqMLHKwewvyFZgfPFyNoLfQqJGvNnet7oeqNXjlx0R3KW
	 9yOZLDp/RqKdSoqup59pXFyiGBMC7G6kqaOylg/Y1UHc0ipILpnoaMMih4q2A2p+4NjAl
	 UQXQYrtJ/SWBqZaDrv0FtYcVuC7IVd/cgvPjcJIGxt4KeIiyWKpplAVQtNlEgJ/S4aTt6
	 bcvuVBtzUCSor/tL7y0VAPD+iG7z5/9Br90U+hCZp4IhgIoAS5ig6yvAFcwu9MEnbaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793538463;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TFNihidVYfGhLHmSjJMIT1Wv5kxpEtJpIMlQ7E/ipCs=;
	b=i/hKVhzeh2NaJrp8NOsHhSAqhYW9+aI3IV2vmJRCzbSKB7s03yXysVYOiZv7PoABEAm+
	 8trHmMQHx49aJUffApWsWYnL25z7k2LVD7t7zk/K1lGxOR6mub2QD5DNud4ABj2t61nNG
	 Q9dR8+m50LumtTFP+Qm6SiL14JEpecWQ0MlJ+2D57ABVeXDXjU7kaBq/Vd6fHR3mVwE9g
	 7/qydHFLSJ6mMph++oSlI1KLkXb7Khs35Amml3/FZXKrN17EknIImcqegds1iCY+Qr17b
	 hHFPIg603GH6ClVQI8bECucX01OkSLWsCzWXUlmpZiSY5IMnBqj9cUaEIRG9WqAAwNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Bs71kuue;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4492606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 13:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Bs71kuue
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1F11F000C1;
	Sun,  1 Nov 2026 13:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793538462;
	bh=TFNihidVYfGhLHmSjJMIT1Wv5kxpEtJpIMlQ7E/ipCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Bs71kuue8Uoby4yTRhdwCB0C+4zSFUhsOiHHf8x9FRMquhwou7DjEVzLM7dcqL+PE
	 hrUya8Z0arlyEPTsrwWanASd3WpbLvWlVB4fYHJTXG4ot58u1Kwoo8Vw+j9IGI4HqC
	 3zVGB81FUZ36Vio1RO4T5CdLo+VCNL42fbfonYqA=
Date: Sun, 1 Nov 2026 14:07:36 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: James Burton <jamesburton@meta.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Eduard <eddyz87@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>
Subject: Re: gotox/INSN_ARRAY cross-subprog fixes: request vuln-fix
 designation and stable tags
Message-ID: <2026110102-jaundice-uptown-dd63@gregkh>
References: <CAJgm7qNx6NBzfxQbwF0ZoMLoULquNpsnrYSL1F3EFf2tztES7Q@mail.gmail.com>
 <2026103022-epilogue-coeditor-0029@gregkh>
 <CAJgm7qMWGF3zWOR=5qO8RWmufGud6fcNBQQxTsVgx=CgvRz3Qg@mail.gmail.com>
 <CAADnVQ+spWODbcC25SwVFXUv+ksPNuVkQgxtq4PwLHdDDsSZCA@mail.gmail.com>
 <CAJgm7qMEz-O1+L2MJz+qqH6-pz_ELaQNG0QQkgMbHOoDi69R4Q@mail.gmail.com>
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
Content-Disposition: inline
In-Reply-To: <CAJgm7qMEz-O1+L2MJz+qqH6-pz_ELaQNG0QQkgMbHOoDi69R4Q@mail.gmail.com>

On Sat, Oct 31, 2026 at 04:07:30PM -0700, James Burton wrote:
> Daniel, Alexei,
> 
> Fair enough on searching lore first. I did, and that's actually what
> prompted the question.
> 
> The same gotox/insn_array feature already has three fixes that only
> needed CAP_BPF and still got CVEs and stable backports:
> 
> - CVE-2026-43321, mark live registers for indirect jumps, in 6.19.6 and 7.0
> - CVE-2026-93043, interpreter fallback BUG_ON for gotox, in 7.2.6 and 7.3
> - CVE-2026-45967, wrong address for insn array offsets, in 6.19.4 and 7.0

Should we go reject these CVEs?  I'll be glad to do so if the bpf
maintainers say we classified these incorrectly.

thanks,

greg k-h
