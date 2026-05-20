Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED2A33D6D8
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 19:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779304517; cv=none; b=crRn+K6krvSxK+ZO3NucimE1mOqazs+SEsegYL/kIZisTCahNe/Rp/DUuK9+/piioP9U3mtOOZtUUtcMJqcgkg4GeObz5G8yEFq7er7lnowvnD9MAeW3T5bX39nWayH6R8dnkI/GCj3okuXVUmGnKdDLV1U8FKZkBbVrkFh1bZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779304517; c=relaxed/simple;
	bh=GoMBdLnBrcbm7Gx7KdtXk8bDQaIvoenjh+iyxSR65i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJqV9TAWdDKCMCuQYQ9OuFGTHBAfiwUTmUdVcy7irQSQJGFMcTr9gEDwZgYo8rdk/8YrhM5NZ7/AA/Py2kjau0hZb52z8S3P+gi8N/+mPaayGzF0xw9zDP/bdWLuZVFX2yOqthtW1uAnK8jEsrdlrahkI7K7zBOj15KqaCsesnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ga4/ibmX; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ga4/ibmX"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso62720995e9.0
        for <bpf@vger.kernel.org>; Wed, 20 May 2026 12:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779304512; x=1779909312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=haqlKhEJxhJQ1BOdNV2hG5Ryfl3eIwbTWa+eU+nTFeo=;
        b=ga4/ibmX/i1rU4wzBRNL2Pwowko9sUNDlFfzlVsfOYYJKAeJvRvlEIfr/loRIdYRA7
         qGcWy+F9+Tudxb61gHXV4yLM+p6YMKTPKjcd3CNrJhTymBtnBpLJ9P0oYmS1SBIJXhUz
         s/cLTzFQUyhy87DMOjDisyoNPf5I0ebi1ynes+51XL1PQ9NYfjzNOj4H7L8Jknyaj4Ue
         +NE2CEAATCHDI1mWk9PhL/p7tOqHPLgnt0Mv1noU5pfDmZpM03y3t05n2xQHwmBsVHfK
         a/Ec6EJ+0zaOqrkdo7LXxvMRQIyiopA/Smq92s+y9gvf8qBH4FvuagzXQJN69Z4+n87u
         nwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779304512; x=1779909312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haqlKhEJxhJQ1BOdNV2hG5Ryfl3eIwbTWa+eU+nTFeo=;
        b=bK3LIzTXRDM5O0zrfLHIwMVv56t/YcwVR3cFKVWBFC4v82higSU5tnM8qhR8/E4t/i
         ZurlZwr80HgTHvNyfoJc9vMSSpb7BtZmypNcy1sw2CiWCTtAV/oce54okwbcp2R92+5T
         ro24g9d2PGjeHuUQXVDDgO99SHgXAXQP3ClJkZVek9o8F2n/l6ApiOzpJmdNwP50BY39
         wdnlfdw+QhwRkJetQYfSfTXPrTFAiK59w8ABRbRkQhCd1GMD/y5Pu/icoM2+WgIZWg3d
         lwMwtOhyWFwq3Dx3uFOJ0pshRKBPGZ8EFwzJcJ26WYJaVFvzuBkt01mADFYEZ1SmxdvV
         SZlQ==
X-Gm-Message-State: AOJu0Yx9Ov55O2eWuYPJsR8uDebE/ZxxCBJIDvoB4NrNXG25yzurpkH9
	jqohXLoXiY+DRonP768FaskWAsucsYAw2A+xUDighXaDY9pT50HiIWL4
X-Gm-Gg: Acq92OG7x6ZN1EzgF6PJwL68odoMrL5K6kvS/PLNsYL04kXjGG6ih2bsfsW91NtXjDo
	lDJU0EADus+AWUYngHfwaFkPqxL1JiJvwQvSxyl4ABjWica+hIX82SHfhkKYSAeQr414jxlllwk
	skrCXkjn40ytEJFZcGnyGxvswouOR27Pl1c60awKd5qeCu6OtvvhJHGxdCnwtJd3WF3up+9r536
	OHPM3lIeYnFTMYE9c2sB92+T9NE/2pSSqNtPZjxiAEH1GxUEkHvL6RpCi44N1bTyywBvn7czFbt
	XHrLs3xZRhpTY6eryYIbGayNvwU8M7Pt/R8m8drbBxBgmPyUumjnCEglxRGh7i87DDznFwNDEFy
	4yrCPlf2bcDs4t44aSR5zQyQv/2v+3ML03LTp5wSVNNVOf8Ep1VIKGK1DBFiiysmOZZvR5bhtj2
	hqqDtSMXyKhnrng5pUcrjtfsP9zP+w1/YMVhLHCnft8cMG1eS+0Jf8MGE=
X-Received: by 2002:a05:600c:c10b:b0:48f:d612:3c59 with SMTP id 5b1f17b1804b1-48fe60eb0f6mr277706925e9.9.1779304512361;
        Wed, 20 May 2026 12:15:12 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033d52c8bsm13494835e9.8.2026.05.20.12.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 12:15:11 -0700 (PDT)
Date: Wed, 20 May 2026 21:15:10 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Jordan Rife <jordan@jrife.io>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, andrii@kernel.org,
	yonghong.song@linux.dev, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH bpf-next v6 4/6] selftests/bpf: add bpf_icmp_send kfunc
 tests
Message-ID: <ag4IPnc_KBHid7Af@gmail.com>
References: <20260518122842.218522-1-mahe.tardy@gmail.com>
 <20260518122842.218522-5-mahe.tardy@gmail.com>
 <q46w47cqezttz2otf76tncxu7sovhywy2dqwcbajigp64uhbtz@eimvxfeeexuz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <q46w47cqezttz2otf76tncxu7sovhywy2dqwcbajigp64uhbtz@eimvxfeeexuz>

On Mon, May 18, 2026 at 06:34:02PM -0700, Jordan Rife wrote:
> On Mon, May 18, 2026 at 12:28:40PM +0000, Mahe Tardy wrote:

[...]

> > +
> > +static int connect_to_fd_nonblock(int server_fd)
> > +{
> > +	struct sockaddr_storage addr;
> > +	socklen_t len = sizeof(addr);
> > +	int fd, err;
> > +
> > +	if (getsockname(server_fd, (struct sockaddr *)&addr, &len))
> > +		return -1;
> > +
> > +	fd = socket(addr.ss_family, SOCK_STREAM | SOCK_NONBLOCK, 0);
> 
> Is the only customization here SOCK_NONBLOCK? Would it be possible to
> simply extend network_helper_opts to make it possible via the existing
> connect_to_fd_opts? 

So first I tried this with a very complicated callback to set NONBLOCK
and the RECVERR for IPv6 but unfortunately the code from the helper
looks like this:

if (connect(fd, (const struct sockaddr *)addr, addrlen)) {
	log_err("Failed to connect to server");
	save_errno_close(fd);
	return -1;
}

And thus I can't really check for EINPROGRESS so it doesn't work.

> Alternatively, is it possible to test with SOCK_DGRAM to avoid the
> handshake timeout issue?

So thanks for suggesting this, I didn't think about it since the whole
point of this was originally for TCP connections in my use case. I tried
it, it kinda simplifies the test code however I feel like it kinda
defeat the whole point of the patch set.

In the case of using connected UDP, you need to send a first pkt to
trigger the BPF prog and from my quick test and glance (might be wrong)
send will immediately fail because the cgroup_skb program will make the
kernel return an error to the syscall from the SK_DROP synchronously.

I think the point of this was that when connecting with TCP, in the case
of a drop, the kernel will just blindly retry to connect and sending an
ICMP control message is a way to stop the kernel immediately and give
the user the immediate feedback they were missing blocking on this.

So you can still modify the bpf prog so that it returns SK_PASS but then
it's not a good illustration of the use of this kfunc, as Martin pointed
out originally, also the fact that you use UDP in the first place is not
a good showcase of the utility of this.

Does it make sense?

> > +	if (fd < 0)
> > +		return -1;
> > +
> > +	err = connect(fd, (struct sockaddr *)&addr, len);
> > +	if (err < 0 && errno != EINPROGRESS) {
> > +		close(fd);
> > +		return -1;
> > +	}
> > +
> > +	return fd;
> > +}
> > +
> > +static void read_icmp_errqueue(int sockfd, int expected_code)
> > +{
> > +	ssize_t n;
> 
> very small nit: Other functions follow reverse xmas tree order but this
> one doesn't which looks kind of weird.

Ahah ok I can reorganize for reverse xmas tree.

> 
> > +	struct sock_extended_err *sock_err;
> > +	struct cmsghdr *cm;
> > +	char ctrl_buf[512];
> > +	struct msghdr msg = {
> > +		.msg_control = ctrl_buf,
> > +		.msg_controllen = sizeof(ctrl_buf),
> > +	};
> > +	struct pollfd pfd = {
> > +		.fd = sockfd,
> > +		.events = POLLERR,
> > +	};
> > +
> > +	if (!ASSERT_GE(poll(&pfd, 1, TIMEOUT_MS), 1, "poll_errqueue"))
> > +		return;
> > +
> > +	n = recvmsg(sockfd, &msg, MSG_ERRQUEUE);
> > +	if (!ASSERT_GE(n, 0, "recvmsg_errqueue"))
> > +		return;
> > +
> > +	cm = CMSG_FIRSTHDR(&msg);
> > +	if (!ASSERT_NEQ(cm, NULL, "cm_firsthdr_null"))
> > +		return;
> > +
> > +	for (; cm; cm = CMSG_NXTHDR(&msg, cm)) {
> > +		if (cm->cmsg_level != IPPROTO_IP ||
> > +		    cm->cmsg_type != IP_RECVERR)
> > +			continue;
> > +
> > +		sock_err = (struct sock_extended_err *)CMSG_DATA(cm);
> > +
> > +		if (!ASSERT_EQ(sock_err->ee_origin, SO_EE_ORIGIN_ICMP,
> > +			       "sock_err_origin_icmp"))
> > +			return;
> > +		if (!ASSERT_EQ(sock_err->ee_type, ICMP_DEST_UNREACH,
> > +			       "sock_err_type_dest_unreach"))
> > +			return;
> > +		ASSERT_EQ(sock_err->ee_code, expected_code, "sock_err_code");
> > +		return;
> > +	}
> > +
> > +	ASSERT_FAIL("no IP_RECVERR/IPV6_RECVERR control message found");
> > +}
> > +
> > +static void trigger_prog_read_icmp_errqueue(struct icmp_send *skel,
> > +					    int code)
> > +{
> > +	int srv_fd = -1, client_fd = -1;
> > +	struct sockaddr_in addr;
> > +	socklen_t len = sizeof(addr);
> > +
> > +	srv_fd = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0,
> > +			      TIMEOUT_MS);
> > +	if (!ASSERT_GE(srv_fd, 0, "start_server"))
> > +		return;
> 
> ASSERT_OK_FD

Sure let's modify all of them thanks for the info!

> 
> > +
> > +	if (getsockname(srv_fd, (struct sockaddr *)&addr, &len)) {
> > +		close(srv_fd);
> > +		return;
> > +	}
> > +	skel->bss->server_port = ntohs(addr.sin_port);
> > +	skel->bss->unreach_code = code;
> > +
> > +	client_fd = connect_to_fd_nonblock(srv_fd);
> > +	if (!ASSERT_GE(client_fd, 0, "client_connect_nonblock")) {
> 
> ASSERT_OK_FD
> 
> > +		close(srv_fd);
> > +		return;
> > +	}
> > +
> > +	/* Skip reading ICMP error queue if code is invalid */
> > +	if (code >= 0 && code <= NR_ICMP_UNREACH)
> > +		read_icmp_errqueue(client_fd, code);
> > +
> 
> Consider doing all cleanup here and just adding a goto label like
> cleanup in test_icmp_send_unreach?

Yeah I thought it was simple enough so that the flow would be natural
like this, but let me reconsider and see.

> 
> > +	close(client_fd);
> > +	close(srv_fd);
> > +}
> > +
> > +void test_icmp_send_unreach(void)
> > +{
> > +	struct icmp_send *skel;
> > +	int cgroup_fd = -1;
> > +
> > +	skel = icmp_send__open_and_load();
> > +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> > +		goto cleanup;
> > +
> > +	cgroup_fd = test__join_cgroup("/icmp_send_unreach_cgroup");
> > +	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
> > +		goto cleanup;
> 
> ASSERT_OK_FD
> 
> > +
> > +	skel->links.egress =
> > +		bpf_program__attach_cgroup(skel->progs.egress, cgroup_fd);
> > +	if (!ASSERT_OK_PTR(skel->links.egress, "prog_attach_cgroup"))
> > +		goto cleanup;
> > +
> > +	for (int code = 0; code <= NR_ICMP_UNREACH; code++) {
> > +		/* The TCP stack reacts differently when asking for
> > +		 * fragmentation, let's ignore it for now.
> > +		 */
> > +		if (code == ICMP_FRAG_NEEDED)
> > +			continue;
> > +
> > +		trigger_prog_read_icmp_errqueue(skel, code);
> > +		ASSERT_EQ(skel->data->kfunc_ret, 0, "kfunc_ret");
> > +	}
> > +
> > +	/* Test an invalid code */
> > +	trigger_prog_read_icmp_errqueue(skel, -1);
> > +	ASSERT_EQ(skel->data->kfunc_ret, -EINVAL, "kfunc_ret");
> > +
> > +cleanup:
> > +	icmp_send__destroy(skel);
> > +	close(cgroup_fd);
> 
> if (cgroup_fd != -1)
> 	close(cgroup_fd);
> 
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/icmp_send.c b/tools/testing/selftests/bpf/progs/icmp_send.c
> > new file mode 100644
> > index 000000000000..6d0be0a9afe1
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/icmp_send.c
> > @@ -0,0 +1,38 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "vmlinux.h"
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_endian.h>
> > +
> > +/* 127.0.0.1 in host byte order */
> > +#define SERVER_IP 0x7F000001
> > +
> > +#define ICMP_DEST_UNREACH 3
> > +
> > +__u16 server_port = 0;
> > +int unreach_code = 0;
> > +int kfunc_ret = -1;
> > +
> > +SEC("cgroup_skb/egress")
> 
> No test for TC?

Indeed, let me add one.

> 
> > +int egress(struct __sk_buff *skb)
> > +{
> > +	void *data = (void *)(long)skb->data;
> > +	void *data_end = (void *)(long)skb->data_end;
> > +	struct iphdr *iph;
> > +	struct tcphdr *tcph;
> > +
> > +	iph = data;
> > +	if ((void *)(iph + 1) > data_end || iph->version != 4 ||
> > +	    iph->protocol != IPPROTO_TCP || iph->daddr != bpf_htonl(SERVER_IP))
> > +		return SK_PASS;
> > +
> > +	tcph = (void *)iph + iph->ihl * 4;
> > +	if ((void *)(tcph + 1) > data_end ||
> > +	    tcph->dest != bpf_htons(server_port))
> > +		return SK_PASS;
> > +
> > +	kfunc_ret = bpf_icmp_send(skb, ICMP_DEST_UNREACH, unreach_code);
> > +
> > +	return SK_DROP;
> > +}
> > +
> > +char LICENSE[] SEC("license") = "Dual BSD/GPL";
> > --
> > 2.34.1
> >
> 
> Jordan

Mahe
Thanks
