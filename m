Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D72D39E6C6;
	Mon, 22 Jun 2026 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122576; cv=none; b=alPIIjMDzrgDsUaGFkCyH+ejavjDGIG60Um9M6kmsH+JExU570EG10jcPl+yVZi8Lj0stn3tWEwmX5lHsmasBDDBzqGn6c28QB6XD16g6cNXLn1VWyuBIHqVEypu2GfI4jtrykDGk9vyzbf4UzU47P2ZUwYSzwT9utTxT3CVb1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122576; c=relaxed/simple;
	bh=dKfybWohSASsPe89t8jIARC8460aGoHyag7Mc6QBxl8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lE0K6B3BIJHg4b+IPTMl9nb70APU4ZX8B51k2kWN7CS57qHSIDnLGxZBA5cyswHJMqDjEO0SG13BdGwArOVBuA8b7bq9Xck0ulz2m4j+GiraD/mqT5+kJYTXfQ74gY6cIfz5pSVJI27+MPaWhG6Tv+Dgcjq90EJSlOo6RiEo+pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SG2XRnqq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SG2XRnqq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE481F000E9;
	Mon, 22 Jun 2026 10:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782122575;
	bh=mWZmZTPHZ8K22xz/s5/6k7OT/phab6SxzhtQKKn0a68=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=SG2XRnqqvokDNzDx2mq+5l610+XuOv5eMkLiPssVytSN4KqhJFA0TmRSTSLEzUNcp
	 2fvbI6l+zo3R+g4sFvKdCQ2m2Vw/+nyAXjyYn4FEEoO6KMrFWPHwDMnM23X6QNEsOC
	 HaNd992VCic3RZjRITPlOpNfbc4WiN5PvDuzC5NXJIV34RnSracu8hga3oc4JRpFgP
	 TTBdO44HMEnHCbOV6dfaXOjQy5Z3LjQS3a3AnXTVhbIryboMKAURqwPvH92ze43qZf
	 eEJGiPxfKSWRtWHzjKU+LpqvmGXyeMNsxdix0PS2dpr9YKTqMMpCnHvCpoiBpneG+F
	 dsj6ezs/xx7hg==
From: Christian Brauner <brauner@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, linux-fsdevel@vger.kernel.org, 
 netdev@vger.kernel.org, bpf@vger.kernel.org, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>
In-Reply-To: <20260617-work-bpf-sock-xattr-v1-0-a1276f7c9da3@kernel.org>
References: <20260617-work-bpf-sock-xattr-v1-0-a1276f7c9da3@kernel.org>
Subject: Re: [PATCH 0/2] Add bpf_sock_read_xattr() kfunc to read socket
 xattrs
Message-Id: <20260622-giraffe-zahntechnik-gepfercht-f9953c9d4a75@brauner>
Date: Mon, 22 Jun 2026 12:02:35 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-7d9ce
X-Developer-Signature: v=1; a=openpgp-sha256; l=1939; i=brauner@kernel.org;
 h=from:subject:message-id; bh=dKfybWohSASsPe89t8jIARC8460aGoHyag7Mc6QBxl8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRZcnhFzpY161QOS0/5Jzsvf5NRsUuN8tQq3cJ3EdfYq
 nZXL37aUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJG9Mgz/HYzsEvy1rGYkdBpd
 9OObxqEobtAoYL110/6T9x+9LtJKYfgrKbv+cJJwya0jT3xDJi/Vtd2yYV7GjIN1ry0zXzrsznr
 CBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Wed, 17 Jun 2026 13:18:26 +0200, Christian Brauner wrote:
> Add bpf_sock_read_xattr() kfunc to read socket xattrs
> 
> In c8db08110cbe ("Merge tag 'vfs-7.1-rc1.xattr' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs")
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
> [...]

Applied to the vfs-7.3.kfunc branch of the vfs/vfs.git tree.
Patches in the vfs-7.3.kfunc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.3.kfunc

[1/2] fs: Add bpf_sock_read_xattr() kfunc to read socket xattrs
      https://git.kernel.org/vfs/vfs/c/f80386e3838e
[2/2] selftests/bpf: Add test for bpf_sock_read_xattr() kfunc
      https://git.kernel.org/vfs/vfs/c/99a63a6aff40

