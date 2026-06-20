Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7221F91E3
	for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 03:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781925644; cv=none; b=oH7TIsSBbY//Dy/5uHS1BLyDQYQsWVOWL0ridS3xHQ4LYvaBZKDAd7QWvOqThoG2AMLP0h2aBSLL/ydpwWIz+HhtvgszNKIEwa8ftSAe5RHtsv78/P9NA0eYthVLZyJANdaGwyM0eEG/BTeXVxZrI6BXc2E6zjI9wic6jyXaHPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781925644; c=relaxed/simple;
	bh=BBwuWlfyu6CpmJmaqQ7OqRxdrmBAG4TceRywkJvwz4g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jOf4Wh0ouaFCbtHOb7Cdi4QJxhJGr7rUW6OodilLDtM1eIC3HuZnGI2bVBfQfylW4uNBpb9gJRSznCMeaSxWcqdO+MluGgHzenXoLLrbxvxHHUoHwuGzi5qppT0s/ke/qprXcpwJ0ocLKYd/504cLoKvsKhTiNnqJFM5aLrngeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xfmq/JWu; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xfmq/JWu"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-442ce0c2770so2334455fac.0
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 20:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781925642; x=1782530442; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gQJghkrz5Uwqrbb7kMScA7hnholHzLSlGz8SYwIGNg=;
        b=Xfmq/JWu8RgMml2H+X96O7Wra0CrJfKC2VMDzA9CaPrw3nVnIXVSaxIICXMEskZ0Xz
         FPh88uISvkVkc6jYlrXx+otqiBeLiDoUq727DepPulBk15I8UuwnGTcpzlGvaRdYCgst
         6WPR7TUT85mlBtli8ZnhNVyoKmSnA8QaQaLl/rcjShvbWI6V0nM39/8OqvfWMM9uDQaa
         uEffoUrSll4tBL8Ec/mIuyU3feM44SGJreTzNFRP2cdb9i2IH6ZX47YeV9XAbvfyKfiy
         MhVFVl3hEQ2i48WC4F1gway6jHVCG4a6gLmZCo8D5B+qtCymlGf5zEMYK9qrUkG9taek
         jNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781925642; x=1782530442;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+gQJghkrz5Uwqrbb7kMScA7hnholHzLSlGz8SYwIGNg=;
        b=bJvS/Z/tLiEBbk06SK54JP1CGeXStWzlnilngmfZzwtdAxQaIZ2S6am6JNE0YNTqgU
         AXJiFa4VA2Gooo4zkcRDANvxW7x+lB00n6Upk/XKQNZdiCNAJ1Nzy2taICiWwEWd9I4b
         9z7DyrS/VMK6+TCHMSeyibllYM847e1XUNm3Yv8mTG1fKVevanogkacPMfGSMPTj8rPg
         Oeig6b8W+ZPRGnIvI2p1NRVuPTBmBrXSnztWcmqPyAA2PAwrSZgyMqy2EWrSinvZvFzy
         r9fO9jRbWuxx0BJJzTzbL5MTVFBMtJ0VI2kwRnBX4ed4Og/hPcpraE5ykTbmYPmXDU7A
         NHLg==
X-Forwarded-Encrypted: i=1; AFNElJ/fbLrHshrgIQ1tqvIUwQQxnj44cXPCFFEYtpKo/ypVIUdwVxBbjZHm+/5PCGvA17fi714=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXwPdZQ8E9lkDowdQ+hGr9x5xIaD26Cj1AgBzb6+Wicp2TT8Y4
	oUpUo9PdLzNhjaMXMKEVHwVvQozbWTcz0kuVenmTLKdQf+SEiSZgnuni
X-Gm-Gg: AfdE7clui8LEayxoF7J4+wK65ngV/E1AkuK1BgolgvV8kNky4zl6iybwepFOLXsBOQc
	mbKyOHtKLwoSlKzRlwO7cw42r+Kat7CwWfOnTZ3CzGjYnxf8pST58OtJO+1qGDhiGNIRmOzODM3
	/CfoXPv8xzx/3N1PZhb5OWePfJ4K2NP06xf5eISrxmkCbjJgwX30txFbgzR/THbjzjL4HK49OYl
	blSjXGTSNsUUCF3XFX8FGeZczcKS3tq26dw34YIax1fw0LizR+g0MXSvL0YQZ5N0sLXrk9DmAth
	8DO0luuI8WtKgh375oijvIcBJam3+trQ0a/gtD00Sp9Ig53Z72DtXY+AOI6+qroXtrmNAYouLeL
	RJhT4VTEK9d1u5+B23Vqj+GLKqN6tSyBUHE6ptJDkTfC6ByRNXEugLgoO+Miztn9Gr61vPyIGPk
	wNuONRfKjrjzzFuuK1zMem22x+Boa52ea6i4JXJel4aXzZBfooPAoIRCOdx3Nvf9kiXgkqUzpqc
	Jvh2u8=
X-Received: by 2002:a05:6870:ac86:b0:439:b99e:4414 with SMTP id 586e51a60fabf-4470a6fa4famr3750999fac.6.1781925642205;
        Fri, 19 Jun 2026 20:20:42 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:58::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472f04236fsm1099930fac.14.2026.06.19.20.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 20:20:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jun 2026 20:20:40 -0700
Message-Id: <DJDJX62AS415.2BVILN08QK149@gmail.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "Simon Horman" <horms@kernel.org>, "Kuniyuki Iwashima" <kuniyu@google.com>,
 "Willem de Bruijn" <willemb@google.com>, <linux-fsdevel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>
Subject: Re: [PATCH 1/2] fs: Add bpf_sock_read_xattr() kfunc to read socket
 xattrs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Christian Brauner" <brauner@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>
X-Mailer: aerc
References: <20260617-work-bpf-sock-xattr-v1-0-a1276f7c9da3@kernel.org>
 <20260617-work-bpf-sock-xattr-v1-1-a1276f7c9da3@kernel.org>
In-Reply-To: <20260617-work-bpf-sock-xattr-v1-1-a1276f7c9da3@kernel.org>

On Wed Jun 17, 2026 at 4:18 AM PDT, Christian Brauner wrote:
> In c8db08110cbe ("Merge tag 'vfs-7.1-rc1.xattr' of git://git.kernel.org/p=
ub/scm/linux/kernel/git/vfs/vfs")
> we added support for extended attributes for sockets. This comes in two
> flavors: sockfs and non-sockfs/filesystem sockets. Filesystem sockets
> are actual filesystem objects so reading xattrs must use dedicated fs
> helpers such as bpf_get_dentry_xattr() and bpf_get_file_xattr(). Those
> are inherently sleeping operations. Sockfs sockets on the other hand
> don't need to use sleeping operations as the underlying data structure
> is lockless. In addition, retrieval of sockfs extended attributes often
> happens from LSM hooks that only provide struct socket and it's
> completely nonsensical to grab a reference to a file, then force a
> sleeping operation to retrieve the xattr and drop the reference. We know
> that the sockfs file cannot go away while the LSM hook runs.
>
> This series adds a bpf_sock_read_xattr() kfunc that, given a struct
> socket, reads a user.* extended attribute from the socket's sockfs inode
> into a bpf_dynptr. Together with fsetxattr() from userspace this lets a
> process label a socket with a user.* xattr and have a BPF LSM program
> retrieve that label locklessly. The kfunc mirrors the existing
> bpf_cgroup_read_xattr(), including the restriction to the user.*
> namespace.
>
> systemd uses user.* xattrs on sockets to implement socket rate limiting
> and to tag sockets for other purposes [1] such as implementing a varlink
> registry. There is currently no efficient way for a BPF program to read
> those labels back. The new helper allows a listening socket marked with
> an extended attribute to be read back during bind/connect and then act
> on the connect()ing socket. Extended attributes make it possible to
> allow an unprivileged user manager such as systemd --user to mark
> sockets from userspace and then rediscover them or implement policies.
>
> The kfunc is registered KF_RCU and only for BPF LSM programs. A struct
> socket is only guaranteed to live in sockfs when an LSM socket hook hands
> it out, which is what keeps SOCK_INODE() valid. Sockets that embed struct
> socket outside sockfs (tun, tap) are only reachable from tracing programs
> and are excluded by the registration. (Btw, for consistency it would
> be nice to force allocation of struct socket from sockfs instead of
> simply embedding it in e.g., struct tun_file which makes the SOCKFS_I()
> pattern a hazard - at least outside of sockfs functions.)
>
> The read never sleeps and takes no lock. For sockfs the value lives in
> the inode's in-memory xattr store and simple_xattr_get() resolves it
> with an RCU-protected rhashtable lookup, taking neither the inode lock
> nor any xattr lock. The kfunc is therefore usable from both sleepable
> and non-sleepable LSM hooks.
>
> Link: https://github.com/systemd/systemd/pull/40559 [1]
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/bpf_fs_kfuncs.c  | 37 +++++++++++++++++++++++++++++++++++++
>  include/linux/net.h |  1 +
>  net/socket.c        | 25 +++++++++++++++++++++++++
>  3 files changed, 63 insertions(+)
>
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 11841c3d4260..85fc9519d1ff 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -11,6 +11,7 @@
>  #include <linux/file.h>
>  #include <linux/kernfs.h>
>  #include <linux/mm.h>
> +#include <linux/net.h>
>  #include <linux/xattr.h>
> =20
>  __bpf_kfunc_start_defs();
> @@ -359,6 +360,39 @@ __bpf_kfunc int bpf_cgroup_read_xattr(struct cgroup =
*cgroup, const char *name__s
>  }
>  #endif /* CONFIG_CGROUPS */
> =20
> +#ifdef CONFIG_NET
> +/**
> + * bpf_sock_read_xattr - read xattr of a socket's inode in sockfs
> + * @sock: socket to get xattr from
> + * @name__str: name of the xattr
> + * @value_p: output buffer of the xattr value
> + *
> + * Get xattr *name__str* of *sock* and store the output in *value_p*.
> + *
> + * For security reasons, only *name__str* with prefix "user." is allowed=
.
> + *
> + * Return: length of the xattr value on success, a negative value on err=
or.
> + */
> +__bpf_kfunc int bpf_sock_read_xattr(struct socket *sock, const char *nam=
e__str,
> +				    struct bpf_dynptr *value_p)
> +{
> +	struct bpf_dynptr_kern *value_ptr =3D (struct bpf_dynptr_kern *)value_p=
;
> +	u32 value_len;
> +	void *value;
> +
> +	/* Only allow reading "user.*" xattrs */
> +	if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
> +		return -EPERM;
> +
> +	value_len =3D __bpf_dynptr_size(value_ptr);
> +	value =3D __bpf_dynptr_data_rw(value_ptr, value_len);
> +	if (!value)
> +		return -EINVAL;
> +
> +	return sock_read_xattr(sock, name__str, value, value_len);
> +}
> +#endif /* CONFIG_NET */

lgtm.
How do you want to route it? Thought vfs tree for the next merge window?
If so
Acked-by: Alexei Starovoitov <ast@kernel.org>
