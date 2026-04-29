Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74582E175F;
	Wed, 29 Apr 2026 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471201; cv=none; b=VHY0XOVUXMxvfWjxQKTKkVyrtktIs89TdLyur3Zns2vqSFTGeVIQV7DEPA1ZyeCPMuh7liPYdpgUgvfxqFrbDSnDasgE7ci1i/J/wpeuhw7ZfHdq8JLNEEZSvBQGTifJgBqxF5+gP+TUp64lbOB23WSN06KuX9vG/VYRU5byIrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471201; c=relaxed/simple;
	bh=dZ2w+VBEAA/EDBR+p4OKVtvlFbQQBIlNpD3rCJ1Nj/A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kK2MySu45SAfu6sbVFstugL7530lMoJ8feUeXqXKRI9nGBP20Qz1AwD8Bfs+W49unIXICRNSMyT5tKzSJo8RmSU1SkY1zxMakBbKHbyJ55dX/Ygbo0JWvIW+H9s+N2MLDUw+IpJJinzrsbS8prHFCXQQKYQPmfKKx7g7wVhWvP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=nStlt2/r; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="nStlt2/r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=bAs6dfUXcn2uCjBe32SgzLgy8d0Iw4HpdZIPVuE09RA=; t=1777471198;
	x=1778075998; b=nStlt2/roUJcXCvwn+rmLO354wdlgPXH3qq607PLUHAJn7SWcKNF8fglKneL2
	K3TQfLOlx632vrG2L5Q1zRvq6Wr+zEXuxpEgptJZ4jtTOMESyh+7f5DbyGvoyYstbufK4C67BI6Db
	tbJqxCTIvffpTsFo1xKIPSpYbdtevoARMw/9kBQWJXULiMiS6zJeYuX22CutIBKhqNUlYaaIckzj1
	CPy2G6nWARCFgiDSeXW2xLBM7uHanINYhg0aTh0OvLbSs2mWidiEyd0R8fNgO9EPBTaVczBMlKQgJ
	cHjRYPLJhYYJfXCctEaPn3VOWoEPHubetTNaSqvZ97WV6Cx43w==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wI5S7-000000028jO-0mzo; Wed, 29 Apr 2026 15:59:47 +0200
Received: from p5dc559e1.dip0.t-ipconnect.de ([93.197.89.225] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wI5S6-00000002a8I-3vYK; Wed, 29 Apr 2026 15:59:47 +0200
Message-ID: <98dfc3ebe6bf519aec70bf629acae897903d8146.camel@physik.fu-berlin.de>
Subject: Re: [PATCH bpf-next] m68k, bpf: Add initial BPF JIT compiler support
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Kuan-Wei Chiu <visitorckw@gmail.com>, geert@linux-m68k.org,
 ast@kernel.org, 	daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	bpf@vger.kernel.org
Date: Wed, 29 Apr 2026 15:59:44 +0200
In-Reply-To: <20260429124046.3480827-1-visitorckw@gmail.com>
References: <20260429124046.3480827-1-visitorckw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Kuan-Wei,

On Wed, 2026-04-29 at 12:40 +0000, Kuan-Wei Chiu wrote:
> Add a BPF JIT compiler for the m68k architecture.
>=20
> The JIT generates m68k machine code targeting m68020+ processors. It
> currently excludes 68000/68010 and coldfire processors, as it relies on
> 32 bit branch displacements (b<cc>.l) to handle large bpf programs.

First of all, this is extremely cool! Thanks a lot for the work!

Secondly, since you seem to be well-versed in compiler-related stuff on
m68k, may I ask you whether you would be interested in helping to fix a
stopper bug in the LLVM M68k backend?

I have outlined the problem in [1], maybe you could help getting this fixed
as this would fully enable LLVM on M68k which means we could finally use
Rust on the architecture and maybe also build the Linux kernel on m68k
with clang.

Thanks,
Adrian

> [1] https://discourse.llvm.org/t/rfh-m68k-implementing-support-for-32-bit=
-relocations/90660

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
