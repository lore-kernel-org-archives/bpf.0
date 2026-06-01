Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055243DF003;
	Mon,  1 Jun 2026 17:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335988; cv=none; b=dtFIRvb6nMLgINZuHxmlxAzqvaKZXYpQivYoCGLdGPct/da6MiL2egp3XO9450IX+8sdDI2LtOsHulVPvlDClDruIMBGfSJqv0E0mpDk6XbMxJCl1IoigLfrl/eOutFHhTBNGtWGQ4VObqyLcrEN6vXWwt+0kI9KQPcpgphfHdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335988; c=relaxed/simple;
	bh=3sdy84BDOZZ9GCa+7G7a8euBbAkMRqixm061bLKdiIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dn2HQSVR6aZjhHRlsr/S+UoPQ25pRECJYVibMZqxxA4YW3GZEP2o6Y/3Q4yQ42QB6rbAFGO5Zf9zf+BTPoZ/19imOr7zuqteNwpdQXrgnidvIVMiz7rq2SoUJ6dLzAVARXBVHxVqcGaWOCp8e3w+5ShUAE1kEOXO95aQ3GxotBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=SwwlzFFb; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="SwwlzFFb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CSzNv37AwbZ34yeGtfqaKjZWoi1h80Uqe0YqIXBcuWU=; b=SwwlzFFbcOre8rlHOsbDi5F+nb
	zIRBw7kp3BEa1hQNNNeC4o/CpdXF2n9AIrnBrhkep4TX9/JkM4GQuTayE6eYa5IIWDkUWlOMFWuiN
	Gb8hB2gZA4hPIkHQcMZTv+cWxFJVmyCZodmqHsTv1a5wINPmMcL2NN8UH03sf0OUN6uVASp1j1uuu
	C8UEv5WeoMQf1Nxm2SAPys0bDfBJrW++SuLTgMZlDmvgBS2V6clZq1vYif9nLahhQcBldtqVaLu7J
	LkMtyqPDAake66LoMQKyDqSJbJRLqotJnBxSlzuRBBoZ1tFlAAh6nhTjmQyS9lb3edV1wFU1p2lgW
	Ij3/nf2Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wU6iW-002LWr-2h;
	Mon, 01 Jun 2026 17:46:25 +0000
Date: Mon, 1 Jun 2026 10:46:21 -0700
From: Breno Leitao <leitao@debian.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH 1/4] bootconfig: return 0 from xbc_snprint_cmdline() for
 a leaf root
Message-ID: <ah3FVZGQLc6MipYA@gmail.com>
References: <20260527-bootconfig_using_tools-v1-1-b6906a86e7d5@debian.org>
 <20260527170522.835641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527170522.835641F000E9@smtp.kernel.org>
X-Debian-User: leitao

On Wed, May 27, 2026 at 05:05:21PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The early return incorrectly assumes `xbc_node_is_leaf(root)` means there are no descendant key/value pairs, causing it to silently skip rendering valid subkeys if the root node has both a value and subkeys.
> --
> 
> commit 7fe40e4bc583f53fe486de6d90af68f475369ee3
> Author: Breno Leitao <leitao@debian.org>
> 
> bootconfig: return 0 from xbc_snprint_cmdline() for a leaf root
> 
> This commit changes xbc_snprint_cmdline() to return 0 instead of an error
> when the root node is considered a leaf, preventing a build failure for
> empty subtrees in the bootconfig tools.
> 
> > diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> > index f445b7703fdd9..3a102c9122f71 100644
> > --- a/lib/bootconfig.c
> > +++ b/lib/bootconfig.c
> > @@ -431,6 +431,16 @@ int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
> >  	const char *val, *q;
> >  	int ret;
> >  
> > +	/*
> > +	 * A leaf @root (e.g. an empty "kernel {}" subtree, or a key whose
> > +	 * only child is a value node) has no descendant key/value pairs to
> > +	 * render. The leaf-finding iterator below would otherwise return
> > +	 * @root itself, which xbc_node_compose_key_after() rejects with
> > +	 * -EINVAL.
> > +	 */
> > +	if (root && xbc_node_is_leaf(root))
> > +		return 0;
> 
> [Severity: High]
> This is a pre-existing issue, but does this early return unintentionally
> skip valid descendant subkeys?
> 
> Looking at include/linux/bootconfig.h, xbc_node_is_leaf() evaluates to true
> if a node has no children or its first child is a value node:
> 
> static inline __init bool xbc_node_is_leaf(struct xbc_node *node)
> {
> 	return xbc_node_is_key(node) &&
> 		(!node->child || xbc_node_is_value(xbc_node_get_child(node)));
> }
> 
> If a bootconfig contains a root node with both a value and subkeys
> (for example, "kernel = val" and "kernel.param = 1"), xbc_node_is_leaf()
> will evaluate to true for the root node.
> 
> Since this patch changes the behavior to return 0 instead of propagating
> the -EINVAL error, will it silently skip rendering these descendant subkeys
> and cause missing kernel command line parameters?
> 
> Would it be safer to drop this early return and instead add a check like
> "if (knode == root) continue;" inside the xbc_node_for_each_key_value() loop
> to skip the root's value while continuing to process its subkeys?


Good catch, you're right. If @root carries both a value and child keys
(e.g. "kernel = val" together with "kernel.foo = bar"),
xbc_node_is_leaf(root) is true -- root's first child is a value node --
so the early return drops kernel.foo=bar, which the pre-patch code did
render.

For v2 I'll drop the early return and skip @root itself inside the loop,
as you suggest:

	xbc_node_for_each_key_value(root, knode, val) {
		/*
			* An empty or value-only @root yields @root itself here;
			* skip it so we still render any real descendant keys
			* (and return 0 rather than -EINVAL for an empty subtree).
			*/
		if (knode == root)
			continue;
		...
	}
