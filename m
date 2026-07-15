Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0B53B2FFF
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 19:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784144298; cv=none; b=r+QhOeY3ZpnSynSkRRQ1HWOm0XHKlkYuhyextMO3QKvO9tZfqR/qatsRD3hY/Dpm+oa63NpISjPK2qCqtw7or+9uhYj92mbJ0D76Co5toLdyDR0TV5gzcU5FKhX0CAmK6UhpE75KFB1g2NjyqsthgPzLucqzRQ3GeAvAOQ6n3nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784144298; c=relaxed/simple;
	bh=L+5stxk9/TZtemXgYOZ5nKN5EvpNt30z+bEOaUlqXaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEtNJK+trnt+0wD34d+60XNjSCw+czHXhUQpIltDFndllSkg//STF6Skg08AM5aKZ716IVHuvdP1sdIVQ9vH3cGKNrcswqITF6CYEpiStjagLAu5+ig4y86K7XZAGwejsdU0nXWlm7DrRrrdip/+DxV6B6OxAiyK/8BYMVAsEYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwpYFHGe; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwpYFHGe"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c99eaa1f020so2409753a12.2
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 12:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784144296; x=1784749096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2/XbfUj40vpAwQblEsfpgBxq5TKOWmuR7bPm/O5WftA=;
        b=CwpYFHGeavEBoO7/bZTmAn3gie+vzSoAMWCh7H3RNkknWp98+SzJubuI1uufyVS64g
         oF3pfok/2UBHJ03Od+pBzjysnA7uRfx+jtA+XBQaiGZssXkNM3U5SP2jdM3iIA4QgeQq
         kQfxNX5gG4vC75bqS84r6e1nH08NPBrmpblm6tURvc92U17LOX9Vpo1BuN+a451rHtHi
         i509rcEt5PW/LzM5s7NANAhGGnrTEbqFSPVIx5EBsxoe6OJzW+vbTDtUIzHXl/LNMeZv
         c74M6NVHCR7Woty7UhG5v2lx/nccoEpsgRLpdJOuvxO/SahelQYlM1+EvejnmcfPkBEi
         LG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784144296; x=1784749096;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2/XbfUj40vpAwQblEsfpgBxq5TKOWmuR7bPm/O5WftA=;
        b=jSw/p0lgoSrTMns/AL9DPNqTOjuX1RWfOLkpsVpDU0oq7CxULeSdlObt+5hC8A95z6
         K28KSnGZjn5VCSiqF37j5hIXNToEC6dlNAR6wKbFR9Br6+q9YwWny+o6D3vAk3EyBpM5
         yig2rRBAEiK3ZgXv3nABe8P3LBdFgkmxCbsKlRZI15kZWGkRX097xzrFGSxDC9PdHcRx
         MpvtgCw86KErmNaFV2w7t+gkAHpXML0dpO9zZB0Msh3/ahvU2PNx9B/R46bXd8G/WOci
         B9vfOg9ArLtwzpfF5w3jz5vKc6jEYkXoAFbP7KDyALa1psN1bMfKVXGd/yfl2ToVJ1CG
         uaWA==
X-Forwarded-Encrypted: i=1; AHgh+Rp5T7QscI8o1wTKi6il28/FSeIv+25qjoP4FbKRt81NTMegxyuNoBxaBVpZGbzRYI4lkVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhMAarff9ZM524R+P+tEspkw8baY0ruZuSbgUC9y/VwfP34vuo
	fcxy33HWzEu+uhrYP5Q1rD4gbVLZGKAyUPtDpjOq351uTrWSJ4lhD1Dr
X-Gm-Gg: AfdE7cm+mdpH1V7KoYSePFbA0JER2ckpmu2VZVeJXrSC64QK61Qy9Gl41eu88cllR4x
	O+uBR2che7aZkC27o0NpeHblwn5o1cDstqDXfBIIJcg7m52a/DLBEPQh08YfGSumB0QtCCi66Z5
	CnXbV+rIyAegSVv5pD+qCeWziCZLjiC4D+UIR8+mnwMPEjCCpkJDvl1926BJr1N+fDs5ONgckI+
	74kXaKCKeTOKWvKEKZ6v2tQBerJFmUDtSQoYz/cLKXnFHtSxOFuI2JjoXEZOp8/k6kDbmOfOrQC
	gaHkJsA4hEMVqmBmV6LtzbbSJFY/pF/BLCB0ppAvo6WwkaCnbmqpdrxjbtMb2/Np0JoOIblpo7Z
	4tN67aB37IT0tOGGzt1IMAabMZIEO2oF+5D9M14sPrKjKdnINr33dXoP6StmSvbjkArNktdf/dp
	eaT76BJu14zdd33EvbqgWDvejrKzk0l+r+yfMcTBWX1306KPVRDyV7
X-Received: by 2002:a05:6a21:6088:b0:3b2:8685:1473 with SMTP id adf61e73a8af0-3c1100092c3mr20598553637.7.1784144296264;
        Wed, 15 Jul 2026 12:38:16 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:575a:5ca:2b13:aa89])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e6a4866sm3682479eec.18.2026.07.15.12.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 12:38:15 -0700 (PDT)
Date: Wed, 15 Jul 2026 12:38:11 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Derek Barbosa <debarbos@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, users@kernel.org, 
	Linux Media Mailing List <linux-media@vger.kernel.org>, Stephen Finucane <stephenfin@redhat.com>, 
	bpf <bpf@vger.kernel.org>, Chris Mason <clm@meta.com>, 
	Christian Brauner <brauner@kernel.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: Linking Patchwork with Sashiko?
Message-ID: <alfgkG4iSC902tZU@google.com>
References: <20260710083845.23c753ca@foz.lan>
 <87wlv2jq4t.fsf@linux.dev>
 <20260713095538.3d5e86f1@foz.lan>
 <20260713094120.GD1127719@killaraus.ideasonboard.com>
 <20260713220427.582b28bf@foz.lan>
 <7ia4mrvtrxjl.fsf@castle.c.googlers.com>
 <20260715005909.GF1656185@killaraus.ideasonboard.com>
 <00a244f8-5be6-4ee7-b5b1-e4cbdcd4fc77@linux.dev>
 <20260715163921.GH1778116@killaraus.ideasonboard.com>
 <20260715174153.GB3846105@ziepe.ca>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715174153.GB3846105@ziepe.ca>

On Wed, Jul 15, 2026 at 02:41:53PM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 15, 2026 at 07:39:21PM +0300, Laurent Pinchart wrote:
> > > Yes, assessing whether AI report is "real" is work, but it's not
> > > reasonable to push this work on already overwhelmed maintainers. And
> > > if AI is wrong, again it's the job of the author to convince the
> > > maintainers it's wrong.
> > 
> > We disagree on this as well. This would force contributors to constantly
> > justify their value against a machine that is known to produce a
> > non-negligible quantity of nonsense. Furthermore, if those generative AI
> > tools are as good as their supporters claim, the time they free for
> > maintainers should outweight the need workload to triage the comments.
> 
> I feel Sashiko and this whole AI world has created alot more work. It
> is not saving time at all. Now I have to go and read every Sashiko
> report to see if there is something important that normal review
> missed. I have fix all the drive by 'this is already broken' stuff it
> finds. We get way more patches than we did before. Now *everything*
> has to be looked at more skeptically if came from some AI slop. I get
> crazy real security reports that need special hand holding now that we
> never got before.

No, we are just becoming aware how awful our code actually is and how
may issues have been overlooked by experienced developers and
maintainers, not even talking about junior contributors.

So save all these "pre-existing issue" reports in todo/ and go over them
when you have a chance.

> 
> Even on the submitting side now I have to run patches through all
> kinds of AI tools to have a solid chance to navigate the new guantlet
> upstream.

Yes, I experience the same. But that just shows that we are not perfect
and prone to making mistakes.

> 
> We aren't saving time, or creating less work. My hope is we are
> creating better quality, higher security and less bugs.

I believe we are. Hopefully as we are fixing all these pre-existing
issues we will be seeing less of them...

Thanks.

-- 
Dmitry
