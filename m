Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1446D2AF00;
	Thu, 23 Apr 2026 05:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776921319; cv=none; b=dWzFKNKsVtaqq8r5DYbMLJOBoTtDihirXgt6AYSP82iVSRH4r6c7d0rYe6mDcLnWuB1oEXVJGtj7XfzKFhZT4gOJxTm0jrS/pUP4lZud3w2prI+4Ml5q8BUhq2vtYzPZL6EY7Xy8fgkJZl70EHyiUci20yy1InnwKPnIxrOxm3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776921319; c=relaxed/simple;
	bh=MW0MYJnHl7iuJABLGZVfG0M1Uho8c6g+rl1kLBd02FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6wzxjgjyGtz1/peS58MJdjfEfsY+WegonsUwB8acTnta5WucJJ9JLaijtrYIuyQsZ6wiuuFNWaZQNsrxowZU6+Ion+QhiD2rOD08C7zkPSbEttGFMjK6j39YJlyo72QIapH1a2hSjRbPsFGCWg4nbwfb5mFy2J9E4kyFw8n8LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bscqkh6R; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bscqkh6R"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3D4ayL5VuO2TsLHF0NOdOb9MEp/M5m70O9sO/EoXii4=; b=bscqkh6RmaiJQG+tiBx9NscI5I
	4KL0QLcwcwa6ZpOzbPQgeWZBjjHbhOulGUFnbQM49+4fKh0wN7XKyDmC6HbzRlrMmEiHLI5uoAijk
	rH1zlf/VR12wV0OiDCfEUK5eP2+OxmLPwpv/CadylFGGDu6PnYW76YBjrR9bi0fqvWpOeQq5ll7dI
	Lq+bLDoVq2E6/WEmERB+qsYTbKrpMZEykqEtGWlnm7OTVan1MPMqyJ6kI/ONbHpK+1fuAiqbcNLCm
	eEditBUGIFSumSXxOdgDQtC3HKBjW1emGj63qAiZQeXcc4SMFJ1FS2LJGyQWIMqnGp3EAqq/KODOT
	G248ISog==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wFmTF-00000008hVg-3ZzT;
	Thu, 23 Apr 2026 05:19:25 +0000
Date: Thu, 23 Apr 2026 06:19:25 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Eulgyu Kim <eulgyukim@snu.ac.kr>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, byoungyoung@snu.ac.kr,
	jjy600901@snu.ac.kr, Alexei Starovoitov <ast@kernel.org>,
	KaFai Wan <kafai.wan@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Subject: Re: [BUG] KASAN: slab-use-after-free in link_path_walk
Message-ID: <20260423051925.GO3518998@ZenIV>
References: <20260423013916.1589029-1-eulgyukim@snu.ac.kr>
 <20260423043906.GN3518998@ZenIV>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423043906.GN3518998@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Apr 23, 2026 at 05:39:06AM +0100, Al Viro wrote:
> Folks, the rules are simple:
> 	* anything that might be accessed in RCU mode (inode very much included
> for objects that are visible in the tree) must be freed after RCU delay; that's
> what ->free_inode() is for.
> 	* anything that can't be freed in such context should either be
> dealt with in ->destroy_inode() (if it isn't needed for RCU-exposed methods)
> or, if it really is needed for those, done via schedule_work() or equivalent
> done by ->destroy_inode().

If you do ->destroy_inode() alone, you must use an explicit call_rcu() in there
(or in ->evict_inode(), for that matter), with everything that must be RCU-delayed
done via that callback; strongly discouraged, though, since it's easier to leave
that to fs/inode.c by turning that callback into ->free_inode().

> Seeing that bpffs has the grand total of zero RCU-exposed methods (no ->d_compare(),
> no ->d_hash(), no ->permission(), no ->d_revalidate(), no ->get_link()) I would
> guess that it's the case of "have your bpf_any_put() done promptly, leave freeing
> the inode and cached symlink body RCU-delayed".

Other than bpffs there are only two instances of super_operations that have non-NULL
->destroy_inode() and NULL ->free_inode():
static const struct super_operations pipefs_ops = {
        .destroy_inode = free_inode_nonrcu,
        .statfs = simple_statfs,
};
which is fine, since pipefs inodes are not exposed to RCU pathwalk at all and
static const struct super_operations btrfs_test_super_ops = {
        .alloc_inode    = btrfs_alloc_inode,
        .destroy_inode  = btrfs_test_destroy_inode,
};
which is definitely not fine, but since that thing is not exposed to regular
syscalls (only to odd internal selftests, what with not being user-mountable),
presumably it gets away with that.  AFAICS, it may end up calling
	cond_resched_rwlock_write(&tree->lock);
from drop_all_extent_maps_fast(), from btrfs_drop_extent_map_range(), called
in btrfs_test_destroy_inode(), so it probably needs to leave that call
of btrfs_drop_extent_map_range() in ->destroy_inode() and use their
regular btrfs_free_inode() for ->free_inode().
