Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A133D16F0
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778256017; cv=none; b=fVVL4uxIFyq51DOQM9kLd1TtkV71Yk8BGo/Nzig4YbzAKHwdyI1wZjGydcWQ+Ik0MyhDVUiEv06vwHPU1HXjIke047o7PEnHx5+1duSsRaNE9fghC4jdP0w0gsJU5GSu5tmJxJQ6nZHWp6TzwA2DEd0igWr33bcqBJdcxFfRrUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778256017; c=relaxed/simple;
	bh=6Of3VLnGhnZNqotYMlZYphjqcYzUugQZ281ApXet29s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpNfmG/M6VAxTrhsEzeTH8VNxWA5g6LXNPBV+fygcwxTfSVcEajQuA9Y0+9dUIhW+sBxyp8z49nL+Lsj25Lh/5MuD93CqpbLfu02w37rcuFRQnw7AASN26PH/y6D8BW7YYZjbDyIV5nnuzR2UNgR2T7m1jiP4Zxfmfh//33I42U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MokCdbdl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GpCyBlHu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MokCdbdl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GpCyBlHu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MokCdbdl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GpCyBlHu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MokCdbdl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GpCyBlHu"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 790DB5D298;
	Fri,  8 May 2026 16:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778256007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LXVVyze4kx8kMS2s6zXyMtskN0p+eWsbnQJaLtfTRVU=;
	b=MokCdbdlVqPFyLxx06jdq1XDoiO9YnmmR9DeOuFs1hxz5a8sWcfgScqRrFqSFR1fhlx7cn
	M6aF/AnbmBIYNIum2n/jIjGgXQsTIwTR27dFFmF8hMoA6CIWZqIDbv+1m19htZxqYgRrhA
	keJUvKVmMFpUaX+QmhFE4w2V7HowfWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778256007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LXVVyze4kx8kMS2s6zXyMtskN0p+eWsbnQJaLtfTRVU=;
	b=GpCyBlHuo6uoF9mfSynsoCqUCL3NqOVk7ALy1192vBbEFlBRpm9LSRXp8AVG2sGoFwcSbx
	WKBa8+8otTAbkiAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MokCdbdl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GpCyBlHu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778256007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LXVVyze4kx8kMS2s6zXyMtskN0p+eWsbnQJaLtfTRVU=;
	b=MokCdbdlVqPFyLxx06jdq1XDoiO9YnmmR9DeOuFs1hxz5a8sWcfgScqRrFqSFR1fhlx7cn
	M6aF/AnbmBIYNIum2n/jIjGgXQsTIwTR27dFFmF8hMoA6CIWZqIDbv+1m19htZxqYgRrhA
	keJUvKVmMFpUaX+QmhFE4w2V7HowfWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778256007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LXVVyze4kx8kMS2s6zXyMtskN0p+eWsbnQJaLtfTRVU=;
	b=GpCyBlHuo6uoF9mfSynsoCqUCL3NqOVk7ALy1192vBbEFlBRpm9LSRXp8AVG2sGoFwcSbx
	WKBa8+8otTAbkiAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3681D593A8;
	Fri,  8 May 2026 16:00:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WXbmCYYI/mljJwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 08 May 2026 16:00:06 +0000
Date: Fri, 8 May 2026 17:00:04 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Vernon Yang <vernon2gm@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	roman.gushchin@linux.dev, inwardvessel@gmail.com, shakeel.butt@linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, surenb@google.com, tz2294@columbia.edu, baohua@kernel.org, 
	lance.yang@linux.dev, dev.jain@arm.com, laoar.shao@gmail.com, 
	gutierrez.asier@huawei-partners.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	bpf@vger.kernel.org, Vernon Yang <yanglincheng@kylinos.cn>
Subject: Re: [PATCH v2 0/4] mm: introduce mthp_ext via cgroup-bpf to make
 mTHP more transparent
Message-ID: <af4HYivyP7LDG2-k@pedro-suse.lan>
References: <20260508150055.680136-1-vernon2gm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260508150055.680136-1-vernon2gm@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.dev,gmail.com,iogearbox.net,google.com,columbia.edu,arm.com,huawei-partners.com,vger.kernel.org,kvack.org,kylinos.cn];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,kylinos.cn:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 790DB5D298
X-Spam-Level: 

On Fri, May 08, 2026 at 11:00:51PM +0800, Vernon Yang wrote:
> From: Vernon Yang <yanglincheng@kylinos.cn>
> 
> Hi all,
> 
> Background
> ==========
> 
> As is well known, a system can simultaneously run multiple different
> scenarios. However, THP is not beneficial in every scenario — it is only
> most suitable for memory-intensive applications that are not sensitive
> to tail latency. For example, Redis, which is sensitive to tail latency,
> is not suitable for THP. But in practice, due to Redis issues, the
> entire THP functionality is often turned off, preventing other scenarios
> from benefiting from it.
> 
> There are also some embedded scenarios (e.g. Android) that directly use
> 2MB THP, where the granularity is too large. Therefore, we introduced
> mTHP in v6.8, which supports multiple-size THP. In practice, however, we
> still globally fix a single mTHP size and are unable to automatically
> select different mTHP sizes based on different scenarios.
> 
> After testing, it was found that
> 
> - When the system has a lot of free memory, it is normal for Redis to
>   use mTHP. performance degradation in Redis only occurs when the system
>   is under high memory pressure.
> - Additionally, when a large number of small-memory processes use mTHP,
>   memory waste is prone to occur, and performance degradation may also
>   happen during fast memory allocation/release.
> 
> Previously, "Cgroup-based THP control"[1] was proposed, but it had the
> following issues.
> 
> - It breaks the cgroup hierarchy property.
> - Add new THP knobs, making sysadmin's job more complex
> 
> Previously, "mm, bpf: BPF-MM, BPF-THP"[2] was proposed, but it had the
> following issues.
> 
> - It didn't address the issue on the per-process mode.
> - For global mode, the prctl(PR_SET_THP_DISABLE) has already achieved
>   the same objective, there is no need to add two mechanisms for the
>   same purpose.
> - Attaching st_ops to mm_struct, the same issues that cgroup-bpf once
>   faced are likely to arise again, e.g. lifetime of cgroup vs bpf, dying
>   cgroups, wq deadlock, etc. It is recommended to use cgroup-bpf for
>   implementation.
> - Unclear ABI stability guarantees.
> - The test cases are too simplistic, lacking eBPF cases similar to real
>   workloads such as sched_ext.
> 
> If I miss some thing, please let me know. Thanks!
>
<snip> 
> kernbench results
> ~~~~~~~~~~~~~~~~~
> 
> When cgroup memory.high=max, no memory pressure, seems only noise level
> changes, mthp_ext no regression.
> 
>                             always                 never               always+mthp_ext
> Amean     user-32    19702.39 (   0.00%)    18428.90 *   6.46%*    19706.73 (  -0.02%)
> Amean     syst-32     1159.55 (   0.00%)     2252.43 * -94.25%*     1177.48 *  -1.55%*
> Amean     elsp-32      703.28 (   0.00%)      699.10 *   0.59%*      703.99 *  -0.10%*
> BAmean-95 user-32    19701.79 (   0.00%)    18425.01 (   6.48%)    19704.78 (  -0.02%)
> BAmean-95 syst-32     1159.43 (   0.00%)     2251.86 ( -94.22%)     1177.03 (  -1.52%)
> BAmean-95 elsp-32      703.24 (   0.00%)      698.99 (   0.61%)      703.88 (  -0.09%)
> BAmean-99 user-32    19701.79 (   0.00%)    18425.01 (   6.48%)    19704.78 (  -0.02%)
> BAmean-99 syst-32     1159.43 (   0.00%)     2251.86 ( -94.22%)     1177.03 (  -1.52%)
> BAmean-99 elsp-32      703.24 (   0.00%)      698.99 (   0.61%)      703.88 (  -0.09%)
> 
> When cgroup memory.high=2G, high memory pressure, mthp_ext improved by 26%.
> 
>                             always                 never               always+mthp_ext
> Amean     user-32    20250.65 (   0.00%)    18368.91 *   9.29%*    18681.27 *   7.75%*
> Amean     syst-32    12778.56 (   0.00%)     9636.99 *  24.58%*     9392.65 *  26.50%*
> Amean     elsp-32     1377.55 (   0.00%)     1026.10 *  25.51%*     1019.40 *  26.00%*
> BAmean-95 user-32    20233.75 (   0.00%)    18353.57 (   9.29%)    18678.01 (   7.69%)
> BAmean-95 syst-32    12543.21 (   0.00%)     9612.28 (  23.37%)     9386.83 (  25.16%)
> BAmean-95 elsp-32     1367.82 (   0.00%)     1023.75 (  25.15%)     1018.17 (  25.56%)
> BAmean-99 user-32    20233.75 (   0.00%)    18353.57 (   9.29%)    18678.01 (   7.69%)
> BAmean-99 syst-32    12543.21 (   0.00%)     9612.28 (  23.37%)     9386.83 (  25.16%)
> BAmean-99 elsp-32     1367.82 (   0.00%)     1023.75 (  25.15%)     1018.17 (  25.56%)
> 
> TODO
> ====
> 
> - mthp_ext handles different "enum tva_type" values. For example, for
>   small-memory processes, only 4KB is used in TVA_PAGEFAULT, while
>   TVA_KHUGEPAGED/TVA_FORCED_COLLAPSE continues to collapse all mthp
>   size. Under high memory pressure, only 4KB is used for
>   TVA_PAGEFAULT/TVA_KHUGEPAGED, while TVA_FORCED_COLLAPSE continues to
>   collapse all mthp size.
> - selftest
> 
> If there are additional scenarios, please let me know as well, so I can
> conduct further prototype verification tests to make mTHP more
> transparent and further clear/stabilize the BPF-THP ABI.

How is it more transparent if you're essentially adding mTHP
micro-programmability from the user's side? This series makes it
_less_ transparent.

If you actually want to make it more transparent, then I would suggest
improving the heuristics such that (m)THP doesn't churn through memory
on high memory pressure. Or such that it doesn't feel extremely compelled
to place the largest THP it can based on vibes.

-- 
Pedro
