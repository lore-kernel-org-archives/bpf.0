Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACE42F851;
	Tue, 24 Mar 2026 21:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774386147; cv=none; b=XPXY7uWOXMxcpGAf4CnCXE+QOGHHqsx7zpWLp6owLNBonAs8aQ3ktUhJQj9RJzUjGD63UHI92D2nX+CetsYexb+KDRWiNCPXAhD2jjJjkkTMdadHhn6UcfoUHmAA1K4Hcp7B8NJ5ZgnpKJXfRikQoL+gtoTkwthm9UdpM6D7M4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774386147; c=relaxed/simple;
	bh=GL+qA4pTv4cS7SCbFLA9KwC0gmU65vrrnM/ayKVBi+4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UMwpHBv5H+09x+JebLZBGUW5OdZqbQAYYfWlMpLkvN97F+5kHDegVRkQq8b8kl6iLmALO5gPHigVyvfUASBmCvfGyhmmhTBFmUISNGFfP/7NmM0Z1VhWwbRM+ympJ4E3aogP3Xd+UZnyB1hwZSL5wtQOQ7CUc+IBRJpBTTWTBI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id AEBC5E0519;
	Tue, 24 Mar 2026 21:02:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 85F4960010;
	Tue, 24 Mar 2026 21:02:21 +0000 (UTC)
Date: Tue, 24 Mar 2026 17:03:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, jolsa@kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-open-source@crowdstrike.com
Subject: Re: [External] Re: [RFC PATCH bpf-next 2/3] ftrace: Use kallsyms
 binary search for single-symbol lookup
Message-ID: <20260324170303.06ec4231@gandalf.local.home>
In-Reply-To: <CAOu3gNiHGBEP2oU07fY73=qOBzLJou+_wUY-6txhrnvRo84pAg@mail.gmail.com>
References: <20260223215113.924599-1-andrey.grodzovsky@crowdstrike.com>
	<20260223215113.924599-3-andrey.grodzovsky@crowdstrike.com>
	<20260225064723.53bcce3e@fedora>
	<CAOu3gNjdE_GaEEC__L=4v44iMJZt_eBN2Se_FotCDjX0BXwi1w@mail.gmail.com>
	<20260225183220.7ba404cf@fedora>
	<CAOu3gNiHGBEP2oU07fY73=qOBzLJou+_wUY-6txhrnvRo84pAg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 85F4960010
X-Rspamd-Server: rspamout06
X-Stat-Signature: h7fagp4qwrkhaaqayk9owyx783odwzfe
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/W8KCwGwVFsfKNqUlrDuuj5/ppcDaWm6I=
X-HE-Tag: 1774386141-79949
X-HE-Meta: U2FsdGVkX1+8qHD8qAOGtORFwQ77mN9ZkRRH7e7C3No+2nN5uYlwOS7pRa48mAlnMZyxdnz3kuoqMDyzkVnIWCkSF0DP+l/B5Uho4ziDsLmEImOOwurKJNazORFf8dJHY+2ywNm7lGfinlFcIImSy3DiT/0ujxe/OT9gijqyvf5G3wdUAaIhn15u0159wLmpjO7o2ygmwJaF9NydHmdOjRnFJPSg/mBMcLh5pl1dQ8/xbvfazBj474ALpVSFDz08emphWzvzGqhajgN8U5kYw+f76pN+CudVMFUf/lJJwUroswxyQHcuMoWyMBeD8i/osH/UPDhQI+v7mY14TYKFCi7ndWQXTkL7ScVtZUEO+41VhZ1dBrMW5cElWech7VT7x38somTGoD9ZMi89VlTFPQ==

On Wed, 25 Feb 2026 20:22:50 -0500
Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:

> On Wed, Feb 25, 2026 at 6:32=E2=80=AFPM Steven Rostedt <rostedt@goodmis.o=
rg> wrote:
> >
> > On Wed, 25 Feb 2026 10:25:04 -0500
> > Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:
> > =20
> > > Hey Steve, are there any extra steps required on my side to make this=
 go
> > > through your tree? =20
> >
> > I see you Cc'd linux-trace-kernel which places it into the tracing
> > patchwork. If there's no dependency on any other patch, I can add it to
> > my 7.1 queue. That is, after I get some more time to review it a little
> > deeper.
> >
> > -- Steve =20
>=20
> There are no dependencies, I performed the original optimization in libbpf
> (patch 1) in hopes this will make session kprobes faster then legacy
> kprobe/kretprobe pairs and when it didn't, I dug deeper and came up
> with this second optimization here (patch 2).
>=20
> Let me know of any issues once you have time to review, in the meantime
> I will roll V2 with all the fixes per Jiri's comments including this patc=
h.

Sorry for the late reply:

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

