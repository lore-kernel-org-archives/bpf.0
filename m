Return-Path: <SRS0=IQzl=XB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFFCC43331
	for <bpf@archiver.kernel.org>; Fri,  6 Sep 2019 15:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8DA2070C
	for <bpf@archiver.kernel.org>; Fri,  6 Sep 2019 15:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392006AbfIFPYi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:24:38 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57656 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfIFPYi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Sep 2019 11:24:38 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.1 #3 (Red Hat Linux))
        id 1i6G6F-0004tJ-9r; Fri, 06 Sep 2019 15:24:35 +0000
Date:   Fri, 6 Sep 2019 16:24:35 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Carlos Neira <cneirabustos@gmail.com>
Cc:     netdev@vger.kernel.org, yhs@fb.com, ebiederm@xmission.com,
        brouer@redhat.com, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v10 2/4] bpf: new helper to obtain namespace
 data from  current task New bpf helper bpf_get_current_pidns_info.
Message-ID: <20190906152435.GW1131@ZenIV.linux.org.uk>
References: <20190906150952.23066-1-cneirabustos@gmail.com>
 <20190906150952.23066-3-cneirabustos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906150952.23066-3-cneirabustos@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 06, 2019 at 11:09:50AM -0400, Carlos Neira wrote:

> +BPF_CALL_2(bpf_get_current_pidns_info, struct bpf_pidns_info *, pidns_info, u32,
> +	 size)
> +{
> +	const char *pidns_path = "/proc/self/ns/pid";

> +	fname = kmem_cache_alloc(names_cachep, GFP_ATOMIC);
> +	if (unlikely(!fname)) {
> +		ret = -ENOMEM;
> +		goto clear;
> +	}
> +	const size_t fnamesize = offsetof(struct filename, iname[1]);
> +	struct filename *tmp;
> +
> +	tmp = kmalloc(fnamesize, GFP_ATOMIC);
> +	if (unlikely(!tmp)) {
> +		__putname(fname);
> +		ret = -ENOMEM;
> +		goto clear;
> +	}
> +
> +	tmp->name = (char *)fname;
> +	fname = tmp;
> +	len = strlen(pidns_path) + 1;
> +	memcpy((char *)fname->name, pidns_path, len);
> +	fname->uptr = NULL;
> +	fname->aname = NULL;
> +	fname->refcnt = 1;
> +
> +	ret = filename_lookup(AT_FDCWD, fname, 0, &kp, NULL);
> +	if (ret)
> +		goto clear;

Where do I begin?
	* getname_kernel() is there for purpose
	* so's kern_path(), damnit
> +
> +	inode = d_backing_inode(kp.dentry);
> +	pidns_info->dev = (u32)inode->i_rdev;

	* ... and this is utter bollocks - userland doesn't
have to have procfs mounted anywhere; it doesn't have to
have it mounted on /proc; it can bloody well bind a symlink
to anywhere and anythin on top of /proc/self even if its
has procfs mounted there.

	This is fundamentally wrong; nothing in the kernel
(bpf very much included) has any business assuming anything
about what's mounted where.  And while we are at it,
how deep on kernel stack can that thing be called?
Because pathname resolution can bring all kinds of interesting
crap into the game - consider e.g. NFS4 referral traversal.
And it can occur - see above about the lack of warranties
that your pathwalk will go to procfs and will remain there.

NAKed-by: Al Viro <viro@zeniv.linux.org.uk>
