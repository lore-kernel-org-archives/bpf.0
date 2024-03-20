Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172B9524D7
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 15:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710950308; cv=none; b=asHg142aSj5/YjdbwqfrVjX++jhpjsrO47Ehm1vDCkct9D1k8FCzwFfhioFR2a5gKF6ovmIjqj8cHS6gONwxM27lGbeajOVq3lb9BiXO15JoJyvgGQ5ELYBG7ILUPbqmYEZACGqFHxDVOYb8DsDAlm1e5akd+FxHRDEAW37oWyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710950308; c=relaxed/simple;
	bh=+EmMFVWqHBGz+K0sFCU1hqRCyZ3dN2E61JqYezUZ78s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDU+S0YzUmpd0qWLBFth4zSQqJB3h5Wk8/c0V9oqtFBytjUEvct+eQSoNfQccy2KkBKZoiSsg3srzW1HLHHWlKCbd3JI/bHOee5w0+qLlm0XgKtxJgmtqMFeHAlQlKm4rbuFHy5SDcn331e4DpiL4Ri1jQPncUJnLALqsVr2nnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=f+ZPhOrO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=unWFs3Pn; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="f+ZPhOrO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="unWFs3Pn"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id EE1DD5C0091;
	Wed, 20 Mar 2024 11:58:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 20 Mar 2024 11:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710950305; x=1711036705; bh=Ho0hC8XaL1
	1/Y1I29SeHGFlxfquNeyzbeY9cSfV6Kz8=; b=f+ZPhOrOFYqURutfVEwSYEcoIp
	s530BCDMM6fIOJOvXn9p/VnnPUNh+9OtWlOYT1h/JwQ06bM5FlkIxHClhr98+h+h
	MWw2s+QvK6lZS0Sj7urxJeYdf/Ig1RSpUHQNbbofMyHZ2bQww59Ousla5cC7eLu8
	kN0Dr8OltGB7QYBY+6tLH/sLoRDtgZzl8Iv8361YkUF3Ms3NGofYijBcRvDVoCir
	C3yBAY/kVmYGk8DK0SuaxHBZLw1322akMbZCw7G2E1JnbAlMiYcOu4zS3CS//NZY
	Qru5d/J7En6TNLXU/C53yrkiGUfpo3Lbxsx3H0MeRHdTCL9WpZ9rnSpWZvMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1710950305; x=1711036705; bh=Ho0hC8XaL11/Y1I29SeHGFlxfquN
	eyzbeY9cSfV6Kz8=; b=unWFs3PnXd/niN/IFGbjlv3/7hqsLEDvVmzRh+TEmxp8
	3bcEO/q1GS5Lq92YyHdKS/g3Sfei1OnHHR2t9RSULkXN8pMyCS961e72UUXajojc
	Y9tFefaJMpAxWR84BPmBN7Y+L9YW9u0cSy/AZgG1EJsC2o8NXs6QZIS/nOqbhELg
	rxexk53lySrvPL2d72iET142gywGQt4BdYXsBM5xDTZBoIMUTduMglL2f3twwfuV
	WTXsLZdzMSe1jsYTQRRCyApcfJNpXhLZyqUMhsyIR9wszs9L+RQ9CnyhIeF69fI/
	okcmAr9AhhwH1PVnpG09/0DxQHHJ6Qq3bDZJoddV4w==
X-ME-Sender: <xms:oQf7ZRdYxV-zGCRim9TQ8MfjrHQuKvmBKUYWErNocBGfvHVMY51Q8Q>
    <xme:oQf7ZfNHVYPNkMXBPzIZpr9UbNpjy8Ud2r3wN0DuAcLavzt_CpatgFm4x3uEkWAFi
    y6sbKQTBmEs0UeoOg>
X-ME-Received: <xmr:oQf7ZahMWI9e10YTD-FyTD-1xsUHR8bBOY2R5QeODK7R7-nZgY2bPGL7aDchHSXify_nvHyxN2jtFJbCwBf5jhKQlH1a6zRU5ocn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeggdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdefhedmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddt
    vdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenuc
    ggtffrrghtthgvrhhnpedvfeekteduudefieegtdehfeffkeeuudekheduffduffffgfeg
    iedttefgvdfhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:oQf7Za__Ov2Ke3fch6B2pUomS5i47LOG4mzcEJGkgncqOLi-AqcySA>
    <xmx:oQf7ZdvbbYdjVZWOZjCa4nYy86qAoc4abpLwHwYm0nSG-KCpHG3zog>
    <xmx:oQf7ZZH6F3Yz_dQMFsfbOBTg-bZDy1LrA9pwPoK7OWL7Lwb0uVVH0g>
    <xmx:oQf7ZUOHnQG3I9JE9xmXwczJVtcjeU5wQKxUzht__X6KbNzbNWqdTQ>
    <xmx:oQf7ZTCv0wmP2FgClcPqEPdmuxKEamc3OY8_8_Iw421dfjOs89bc5g>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Mar 2024 11:58:24 -0400 (EDT)
Date: Wed, 20 Mar 2024 09:58:23 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, jolsa@kernel.org, quentin@isovalent.com, 
	eddyz87@gmail.com, andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v5 2/2] pahole: Inject kfunc decl tags into BTF
Message-ID: <uox7naeptmposcheifiumzhuqfxn52b453fffzmanv6pjjgqqk@5tpekemnghhz>
References: <cover.1710532093.git.dxu@dxuuu.xyz>
 <088c4362fa9f080c319df7c49bc6a4e1b6ae98e7.1710532093.git.dxu@dxuuu.xyz>
 <6c178658-d5b3-4b71-b385-5ba95349c8ab@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c178658-d5b3-4b71-b385-5ba95349c8ab@oracle.com>

Hi Alan,

On Wed, Mar 20, 2024 at 12:54:11PM +0000, Alan Maguire wrote:
> On 15/03/2024 19:48, Daniel Xu wrote:
> > This commit teaches pahole to parse symbols in .BTF_ids section in
> > vmlinux and discover exported kfuncs. Pahole then takes the list of
> > kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.
> > 
> > Example of encoding:
> > 
> >         $ bpftool btf dump file .tmp_vmlinux.btf | rg "DECL_TAG 'bpf_kfunc'" | wc -l
> >         121
> > 
> >         $ bpftool btf dump file .tmp_vmlinux.btf | rg 56337
> >         [56337] FUNC 'bpf_ct_change_timeout' type_id=56336 linkage=static
> >         [127861] DECL_TAG 'bpf_kfunc' type_id=56337 component_idx=-1
> > 
> > This enables downstream users and tools to dynamically discover which
> > kfuncs are available on a system by parsing vmlinux or module BTF, both
> > available in /sys/kernel/btf.
> > 
> > This feature is enabled with --btf_features=decl_tag,decl_tag_kfuncs.
> > 
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> 
> This is great work; a lot of steps needed to collect this info, but it's
> really valuable!
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>
> 
> BTW we need something like the attached patch to switch to using
> --btf_features for pahole 1.26 and later; will I send it officially or
> do you have something that does the same that you want to roll into your
> bpf-next series? Let me know what works from your side. Thanks!

I was planning on sending that with the bpftool changes. IIRC there are
a few conflicts with generated prototypes to fix. I think Andrii had
const-ified some kfunc params from userspace side but not kernel. I
probably need to go fixup the kernel side.

Thanks,
Daniel
