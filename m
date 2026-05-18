Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DC235CB61
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 10:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779101325; cv=none; b=h9PWQxjsLLAV4i77fcwRgnOKW/l9WRP0GJP/Dj0mYedqbl3iUAEIs2fGeHpJBsqob//NOtrF2uRU/6vK6JsM+HgHNFWAmORaxC9lmWRWdaDBowqu0TfmcsiBoJHjQPQ4gIk7esMzDsJGfOxz1yg49YXSaI50p+4sbk/IDb0twoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779101325; c=relaxed/simple;
	bh=9eqBSU6bS6ELUkt4XLYwS4O8nD77BHPKLRhElrn2RiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uq99wMOAhX3jR3RvTh16bNNpvO0l3u0RYjKmOB6/Du2zaxsDt2+CjxM7S6p2+e/s1qkeKD22XOe0/+B139raNNMHrPkynqFacUypwclFnlzrQEWs2SOlL0koq7YRkJWRoEbxT7XnQ2hiFD8cBcwbX8OMs1kUBJfpwjfAMNaHUP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r3djK+US; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3djK+US"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45e6a4d0be0so718448f8f.1
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 03:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779101314; x=1779706114; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3UVJjriOurip2RmNBt+r/CGVEP8Shyp9h4jU4NjixPs=;
        b=r3djK+USW6slSwIFtJhBPeoLWivtnI2IQGvg/fNhvtagMdvKAsXlG1BfBorYIqn28o
         R2t6KJ9OeuWWe6qvKRM5EbJzp8VMtxkIjvkZVS24J97OzOlY1h8fTT0xaF2TGQ0k5i89
         6qfbnUvn3cCqvtWff815vqqa5FMQgkdyBn3uTl35VjNxNOP+dxGbPeoZgm5SJ8hNSKeE
         Xj59B5u9zMO+7NWa7z8E5MlFlbyKMNOvn/raE+LnDGtaE4B0LkPsBIerZqyn5Os9cEMj
         QIqesNLz7SB3UHfTMtHt+oCXF1W66IBn3mhP/5U4l1O5nDDmIwgYdYuRR4qpCdupD6WE
         j3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779101314; x=1779706114;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3UVJjriOurip2RmNBt+r/CGVEP8Shyp9h4jU4NjixPs=;
        b=XwSiveGluDR1iAT+ACfhr4qlEBEVPj699OdfynylN+qjX74sB3Yp803zwPoCqc9Ok/
         Aw3dl+sfWeW7BnHCMbg2vPPnHSFQ7vFbtANNeaIYszvHnoOpX2P371jETEJCMX8KpO0x
         3nYUonFIe23oHE+t0jfej0QvAox0jgzTZ65CQtcR88oD36Mi7n5wTgkGxd/hUo5NFrni
         oHnlj3YJH8ZJlFZH1maZb0ZWHFlEWuV5H/plie0Sw+BHh+Dh3OelFhxQYA8hg4OHro08
         Yh+bwrN1VbsckZLQbEM/u9UFmQsMp0CKuyOB/S74bqvijMwNpeaVOpdxNne4Bqd4Yd+A
         Usgw==
X-Gm-Message-State: AOJu0Yx174CuvK/9BtvfaCEIrYIrgvVECpn2NOgNi34kGQbA7JADVWWa
	67PP3Ph7ingrdOj+JygeMQVZF5Rb1IghKDnTPRs0zmSWG9prH32Rn5VLmdDYL68E
X-Gm-Gg: Acq92OEKbfsVtlfAnlGYZtyl0N8S65sjT9gMwLPOoO6dWc4liiEaAMKMRjSqGJGngCd
	ixhGqLykDphGfyZFfG0jXrUoPMipufhpp5tU2KT6xHlp+surZ2ZpQFC1UXVGbgLS1YzFbIOb1Dl
	r6c2SHZpjaJXMh5EWRZyN7EGSqWCGCcFua4VqA4033iUuoDrjpj7WNdtBi+Jw2tsDmV/C8i4+8s
	f4rJPuXLkihW1iNZgveW/RbTfDovTQMKUnQCOxGsfJLKPvewqbWBCKweNkxGQA3goMOpoztJXUR
	Q6DV7H87h0Z5qCwxc+C4FM1HrhKEQyxhOgBIu6ivnRhUmKCpS7vGqPn4JcKmk1tgJu6wnTr3lCV
	vscziHs+fG5+mJyfsrT2iOsMxA7LQByaXcRoVr8+DnZ5p4jcdcWMqY70mdEoafEIrTwpyeQH/hK
	cJnXlOQqTtJpLCqSJ8fVoyOUnR0Pk6gHDRGzz5WGR3HKXi9MfqdHv+ncz5ZWd3
X-Received: by 2002:a05:600d:8496:10b0:48f:eb8b:9980 with SMTP id 5b1f17b1804b1-48feb8b9ademr132451955e9.30.1779101313032;
        Mon, 18 May 2026 03:48:33 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe57944c1sm269031135e9.7.2026.05.18.03.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 03:48:32 -0700 (PDT)
Date: Mon, 18 May 2026 12:48:30 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 4/4] selftests/bpf: add bpf_icmp_send
 recursion test
Message-ID: <agrufs1IOhth-U2X@gmail.com>
References: <20260515194746.50920-5-mahe.tardy@gmail.com>
 <20260515210052.BFCB1C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260515210052.BFCB1C2BCB0@smtp.kernel.org>

On Fri, May 15, 2026 at 09:00:52PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Missing packet filtering in root cgroup program causes system disruption and state corruption.
> - [Medium] Uninitialized `unreach_type` prevents ICMP generation and causes guaranteed test failure.
> --
> 
> commit 58dd624e2dc9a29c48c701ba76fcd20e713e626f
> Author: Mahe Tardy <mahe.tardy@gmail.com>
> 
> selftests/bpf: add bpf_icmp_send recursion test
> 
> This commit adds a new test to verify that bpf_icmp_send returns -EBUSY
> when recursion occurs. It attaches a BPF program to the root cgroup to
> intercept the generated ICMP packets.
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> > index d9badfc6e620c..2363b1c7c711c 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> 
> [ ... ]
> 
> > @@ -173,3 +175,41 @@ void test_icmp_send_unreach(void)
> >  	icmp_send__destroy(skel);
> >  	close(cgroup_fd);
> >  }
> > +
> > +void test_icmp_send_unreach_recursion(void)
> > +{
> > +	struct icmp_send *skel;
> > +	int cgroup_fd = -1;
> > +
> > +	skel = icmp_send__open_and_load();
> > +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> > +		goto cleanup;
> > +
> > +	if (setup_cgroup_environment()) {
> > +		fprintf(stderr, "Failed to setup cgroup environment\n");
> > +		goto cleanup;
> > +	}
> > +
> > +	cgroup_fd = get_root_cgroup();
> > +	if (!ASSERT_GE(cgroup_fd, 0, "get_root_cgroup"))
> > +		goto cleanup;
> > +
> > +	skel->links.recursion =
> > +		bpf_program__attach_cgroup(skel->progs.recursion, cgroup_fd);
> > +	if (!ASSERT_OK_PTR(skel->links.recursion, "prog_attach_cgroup"))
> > +		goto cleanup;
> > +
> > +	trigger_prog_read_icmp_errqueue(skel, ICMP_HOST_UNREACH, AF_INET, "127.0.0.1");
> 
> Is it necessary to set skel->bss->unreach_type before triggering the program?

Yes it's done in trigger_prog_read_icmp_errqueue.

> In progs/icmp_send.c, unreach_type defaults to 0. Looking at bpf_icmp_send()
> in net/core/filter.c, for IPv4 it requires type to be exactly ICMP_DEST_UNREACH (3),
> otherwise it returns -EOPNOTSUPP:
> 
> net/core/filter.c:bpf_icmp_send() {
> ...
> 	case htons(ETH_P_IP):
> 		if (type != ICMP_DEST_UNREACH)
> 			return -EOPNOTSUPP;
> ...
> }
> 
> If the kfunc returns -EOPNOTSUPP (-95), no ICMP packet is generated, which seems
> like it would prevent the recursion this test is designed to verify and cause
> the assertions below to fail.

I think Sashiko is confused here as the type is indeed set during this
test that actually passes correctly as expected.

> 
> [ ... ]
> 
> > diff --git a/tools/testing/selftests/bpf/progs/icmp_send.c b/tools/testing/selftests/bpf/progs/icmp_send.c
> > index 6e1ba539eeb0f..a2ef6a02c2cb0 100644
> > --- a/tools/testing/selftests/bpf/progs/icmp_send.c
> > +++ b/tools/testing/selftests/bpf/progs/icmp_send.c
> 
> [ ... ]
> 
> > +SEC("cgroup_skb/egress")
> > +int recursion(struct __sk_buff *skb)
> > +{
> > +	void *data = (void *)(long)skb->data;
> > +	void *data_end = (void *)(long)skb->data_end;
> > +	struct iphdr *iph;
> > +	int ret;
> > +
> > +	iph = data;
> > +	if ((void *)(iph + 1) > data_end || iph->version != 4)
> > +		return SK_PASS;
> 
> Will this cause system-wide disruption and state corruption by intercepting all
> IPv4 traffic?
> 
> Because this program is attached to the global root cgroup, it will intercept
> all egress traffic on the host. Without further filtering for specific test
> traffic (like protocol, port, or destination IP), any background IPv4 traffic
> will trigger the program and call bpf_icmp_send().
> 
> This seems like it would generate ICMP Destination Unreachable messages for all
> legitimate background connections (e.g., SSH, DNS, or other selftests),
> causing an ICMP storm.
> 
> Additionally, concurrent background traffic might cause races on rec_kfunc_rets
> and rec_count:

Ok let's forget about this, I'll just revert to SK_DROP and confirm that
this will not cause a system-wide disruption and state corruption for
this test case. I need to use the host root cgroup for my test to work
and this should be fine.

> > +
> > +	/* This call will provoke a recursion: the ICMP packet generated by the
> > +	 * kfunc will re-trigger this program since we are in the root cgroup in
> > +	 * which the kernel ICMP socket belongs. However when re-entering the
> > +	 * kfunc, it should return EBUSY.
> > +	 */
> > +	ret = bpf_icmp_send(skb, unreach_type, unreach_code);
> > +	rec_kfunc_rets[rec_count & 1] = ret;
> > +	__sync_fetch_and_add(&rec_count, 1);
> > +
> > +	/* Because we attach the root cgroup, let all traffic pass to avoid
> > +	 * disrupting unrelated network activity. Otherwise we could just let the
> > +	 * first ICMP error message pass to trigger recursion and drop the rest.
> > +	 */
> > +	return SK_PASS;
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260515194746.50920-1-mahe.tardy@gmail.com?part=4
