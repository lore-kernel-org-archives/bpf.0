Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9886018DB2A
	for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 13:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769433862; cv=none; b=Gv0XHSLxFru6QUUBuBinqWc9ZrevKQgZn74v33I2HfpIBFiZi7WqEslW/g4t2QLf5eZn2WQHt+rGJmpzRZFY5EfzBHae+Zco7cG3dGhMqFUzgDRtl0kuZ/qnCs3nn5RWm4oA10ECzckGtPNgwWsYpMMtwb9M30v5xssZznapgfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769433862; c=relaxed/simple;
	bh=VGjeboLj0jFOoNx6nYflmgEmBtnwF2HIvSD2t7qQ5pM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+QNje5WKNIXyOgckwNqseDIDJX84FXr4O3nGmNS22+G7liO1WYvaMp351iookSVXLj98c51qiTeNbNrsuUsfDzM1Is04zn/WqFFG6T+zPJOkFC2KshZQcaULgOy2FYcQaN13+1ynuZVv+kKT/Hd7+RLAm1ZISV1xtqS4CRMxdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=dTZZMUG6; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="dTZZMUG6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=NzFq04HACR8DAAPgEJoZkSi+K5Nj10GJILWctjkDGno=; b=dTZZMUG6sHOdvllqGQOUOQCv27
	JXdiJxDq71q/UNwsc/yP/k+24jDd3WDMwLDCrD5dq4nP6VM9giHWu33i9Cvg6EdXOXEJxzrv2K/ES
	u3UX0Nex3/7N+Hpd0qWYdjdTmPRT2dI/+FFrHvBfO9A9F7HcsJ8KJVNgBcVfeK8kci55LTmEaDA0k
	bZAPej0bI7YKVq9kdE+nRgq1ROX/AIrbHt3Mq3BDVsRpGZrlVg0rRu4PXr8OxM0NIVUZgF5eFXyzY
	SZ8gMxN3+0FT8yXpAYbi4jWfR1VUaEKWJg8hzJodi+QCvdVj8eb9tj600tr00grqGwkjVHzTxK1f0
	edAkiBmw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vkMZe-000GkW-1P;
	Mon, 26 Jan 2026 14:24:10 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1vkMZd-000BEw-2W;
	Mon, 26 Jan 2026 14:24:10 +0100
Message-ID: <4cc162d4-9d19-4406-a93c-d6dcdf65f55f@iogearbox.net>
Date: Mon, 26 Jan 2026 14:24:09 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: fix TCX/netkit detach permissions when prog FD isn't
 given
To: Guillaume GONNET <ggonnet.linux@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, john.fastabend@gmail.com,
 Martin KaFai Lau <martin.lau@linux.dev>
References: <20260124214328.185113-1-ggonnet.linux@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20260124214328.185113-1-ggonnet.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27892/Mon Jan 26 08:24:15 2026)

On 1/24/26 10:43 PM, Guillaume GONNET wrote:
> Since c8644cd0e, BPF permissions are indirectly checked by having a
> program FD or bpffs ACL. When using BPF_PROG_DETACH command on TCX or
> netkit device, it's not required to provide a program FD. Instead, the
> program can be specified using a relative specifier (eg., BPF_F_AFTER).
> 
> In this case, there is no permission check as there is no FD involved,
> so any user can execute that detach command. This is problematic when
> BPF is used to filter out packets not intended to user as it can just
> remove the filter from the network interface.
> 
> For this reason, require CAP_NET_ADMIN or CAP_SYS_ADMIN in detach (only
> when the BPF program FD isn't provided).
> 
> Signed-off-by: Guillaume GONNET <ggonnet.linux@gmail.com>
> ---

$subj should be [PATCH bpf] and as the AI review flagged, Fixes tag would
make sense so that this also gets backported into stable.

>   kernel/bpf/syscall.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 3c5c03d43f5f..d1600aef6e03 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4563,6 +4563,8 @@ static int bpf_prog_detach(const union bpf_attr *attr)
>   			prog = bpf_prog_get_type(attr->attach_bpf_fd, ptype);
>   			if (IS_ERR(prog))
>   				return PTR_ERR(prog);
> +		} else if (!bpf_net_capable()) {
> +			return -EPERM;
>   		}
>   	} else if (is_cgroup_prog_type(ptype, 0, false)) {
>   		if (attr->attach_flags || attr->relative_fd)

Looks reasonable to me. I looked at the other types as well, and as far as I
can see for all the others you need to have a valid program fd in order to
do anything in terms of modifications. Similar to BPF_LINK_{CREATE,UPDATE}
and BPF_PROG_ATTACH. This assumes you either had a BPF token or CAP_NET_ADMIN
at the time of the program creation or the correct permissions in BPF fs
via BPF_OBJ_GET. Anyway, I would change this slightly into the below given
the above makes assumptions that the detach is always about networking
programs and it might not be in future.

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e5be698256d1..ffd22321aa63 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2623,6 +2623,11 @@ static inline bool bpf_bypass_spec_v4(const struct bpf_token *token)
  		bpf_token_capable(token, CAP_PERFMON);
  }
  
+static inline bool bpf_net_capable(void)
+{
+	return capable(CAP_NET_ADMIN) || capable(CAP_SYS_ADMIN);
+}
+
  int bpf_map_new_fd(struct bpf_map *map, int flags);
  int bpf_prog_new_fd(struct bpf_prog *prog);
  
diff --git a/include/linux/bpf_mprog.h b/include/linux/bpf_mprog.h
index 929225f7b095..0b9f4caeeb0a 100644
--- a/include/linux/bpf_mprog.h
+++ b/include/linux/bpf_mprog.h
@@ -340,4 +340,14 @@ static inline bool bpf_mprog_supported(enum bpf_prog_type type)
  		return false;
  	}
  }
+
+static inline bool bpf_mprog_detach_empty(enum bpf_prog_type type)
+{
+	switch (type) {
+	case BPF_PROG_TYPE_SCHED_CLS:
+		return bpf_net_capable();
+	default:
+		return false;
+	}
+}
  #endif /* __BPF_MPROG_H */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4ff82144f885..4ca90020876f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1366,11 +1366,6 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
  	return ret;
  }
  
-static bool bpf_net_capable(void)
-{
-	return capable(CAP_NET_ADMIN) || capable(CAP_SYS_ADMIN);
-}
-
  #define BPF_MAP_CREATE_LAST_FIELD excl_prog_hash_size
  /* called via syscall */
  static int map_create(union bpf_attr *attr, bpfptr_t uattr)
@@ -4565,7 +4562,8 @@ static int bpf_prog_detach(const union bpf_attr *attr)
  			prog = bpf_prog_get_type(attr->attach_bpf_fd, ptype);
  			if (IS_ERR(prog))
  				return PTR_ERR(prog);
-		}
+		} else if (!bpf_mprog_detach_empty(ptype))
+			return -EPERM;
  	} else if (is_cgroup_prog_type(ptype, 0, false)) {
  		if (attr->attach_flags || attr->relative_fd)
  			return -EINVAL;

