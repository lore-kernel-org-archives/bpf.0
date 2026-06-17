Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1BA394793;
	Wed, 17 Jun 2026 11:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781695127; cv=none; b=Bj11N6hvG5LTQH9R9cuNwgSHvwJqgVMBi/5pp5LqG6aqxvZ+ExNHIib55UusH7UB1sN01Q39CUX9AiWTCBo8NocE7wWlA+A4zxK+JWSxKBkIVmFDfEz5FTgmAUDVXKPCrjbJ31niB0sc5UKKK2C0YE1BBNrFLIvwsHj1s6ViHUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781695127; c=relaxed/simple;
	bh=RlnSDe8jTbvt6nTll+OU8DpOGpiGyEo+2R+RdH0TcI0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HUl2xH7FRq1UHtJ+wKKLQYtZAdHwlukh7KSBLYj3xYi2BZKKiH1HdulP6C3t8YUUS++gl5HRy5mv1QKFjbb8dLT+tqFpRsxEcLIkb/c1PVuJS/tOtqej0WEYJ9pXo7VL7EY4H4eGtti3pdy+O9QZUv2AQ4nNJcZn03oIc/tWAYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CesLbRwW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CesLbRwW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC011F00A3D;
	Wed, 17 Jun 2026 11:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781695124;
	bh=UfBJt+LNJ9jrCs3poe+MX0Rqq/0jXvVOHqHItbwOlTI=;
	h=From:Subject:Date:To:Cc;
	b=CesLbRwWZAsJTqbNT62CZ83MCeUQlmp9s8DXamFQmeRrCZjrYTA6b7+umICkOH2Hd
	 0MwUg6MWMIr4/7U/EXfDqChhkayKF2WgKTTeCdBFZLXHxO8AP3M+1UW3QONcK/hmjO
	 +1tTbq1xsYYru2VPF0mT6Hg5OXc5jVW++mu0XnXg0EAVYWsZGHk33T2ju+WFRspxsV
	 SyuGsB4yS/F6jrCaGpq8qsFaWvJe9LEs/LWU4t77PqYI2JanrlHrVI4C7N+dZNmbxD
	 WO3ibszcJ6HT63yPelw5pdhLdflH/W9xlgzwmdQkJ36wV68nX06a2PVjftAquU8buH
	 2Dw8XDTGBkgKw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/2] Add bpf_sock_read_xattr() kfunc to read socket xattrs
Date: Wed, 17 Jun 2026 13:18:26 +0200
Message-Id: <20260617-work-bpf-sock-xattr-v1-0-a1276f7c9da3@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIKCMmoC/yWMQQ6CMBBFr0Jm7RhAU8CrEBdtnUolaclMRRLC3
 W11+V7+fzsIsSeBW7UD0+rFx5ChOVVgJx2ehP6RGdq6VbVqOvxEntEsDiXaGTedEuOlI3u1w9D
 0vYL8XJic337V8f5neZsX2VRSZWG0EBrWwU5FrU7ORcFxfAHX3FbIkgAAAA==
X-Change-ID: 20260617-work-bpf-sock-xattr-37ec4c991886
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, linux-fsdevel@vger.kernel.org, 
 netdev@vger.kernel.org, bpf@vger.kernel.org, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-4090c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3624; i=brauner@kernel.org;
 h=from:subject:message-id; bh=RlnSDe8jTbvt6nTll+OU8DpOGpiGyEo+2R+RdH0TcI0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQZNfVLzxTxKW92D9i7LHWGX0l+zjX/hLYb3i7Bdn9LE
 9tWKl7uKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmMghYUaGv8ZJN6af+Ri1abdO
 3U2JsgdRVYy1hxw3Zly4d6BWeNH8HkaGl3Oa1meujo5Kj983/V/uYcvvOobx7xfzX0xl+Zz/81U
 QMwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

In c8db08110cbe ("Merge tag 'vfs-7.1-rc1.xattr' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs")
we added support for extended attributes for sockets. This comes in two
flavors: sockfs and non-sockfs/filesystem sockets. Filesystem sockets
are actual filesystem objects so reading xattrs must use dedicated fs
helpers such as bpf_get_dentry_xattr() and bpf_get_file_xattr(). Those
are inherently sleeping operations. Sockfs sockets on the other hand
don't need to use sleeping operations as the underlying data structure
is lockless. In addition, retrieval of sockfs extended attributes often
happens from LSM hooks that only provide struct socket and it's
completely nonsensical to grab a reference to a file, then force a
sleeping operation to retrieve the xattr and drop the reference. We know
that the sockfs file cannot go away while the LSM hook runs.

This series adds a bpf_sock_read_xattr() kfunc that, given a struct
socket, reads a user.* extended attribute from the socket's sockfs inode
into a bpf_dynptr. Together with fsetxattr() from userspace this lets a
process label a socket with a user.* xattr and have a BPF LSM program
retrieve that label locklessly. The kfunc mirrors the existing
bpf_cgroup_read_xattr(), including the restriction to the user.*
namespace.

systemd uses user.* xattrs on sockets to implement socket rate limiting
and to tag sockets for other purposes [1] such as implementing a varlink
registry. There is currently no efficient way for a BPF program to read
those labels back. The new helper allows a listening socket marked with
an extended attribute to be read back during bind/connect and then act
on the connect()ing socket. Extended attributes make it possible to
allow an unprivileged user manager such as systemd --user to mark
sockets from userspace and then rediscover them or implement policies.

The kfunc is registered KF_RCU and only for BPF LSM programs. A struct
socket is only guaranteed to live in sockfs when an LSM socket hook hands
it out, which is what keeps SOCK_INODE() valid. Sockets that embed struct
socket outside sockfs (tun, tap) are only reachable from tracing programs
and are excluded by the registration. (Btw, for consistency it would
be nice to force allocation of struct socket from sockfs instead of
simply embedding it in e.g., struct tun_file which makes the SOCKFS_I()
pattern a hazard - at least outside of sockfs functions.)

The read never sleeps and takes no lock. For sockfs the value lives in
the inode's in-memory xattr store and simple_xattr_get() resolves it
with an RCU-protected rhashtable lookup, taking neither the inode lock
nor any xattr lock. The kfunc is therefore usable from both sleepable
and non-sleepable LSM hooks.

Link: https://github.com/systemd/systemd/pull/40559 [1]

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (2):
      fs: Add bpf_sock_read_xattr() kfunc to read socket xattrs
      selftests/bpf: Add test for bpf_sock_read_xattr() kfunc

 fs/bpf_fs_kfuncs.c                                 | 37 ++++++++++++
 include/linux/net.h                                |  1 +
 net/socket.c                                       | 25 ++++++++
 tools/testing/selftests/bpf/bpf_experimental.h     |  3 +
 .../testing/selftests/bpf/prog_tests/sock_xattr.c  | 67 ++++++++++++++++++++++
 .../testing/selftests/bpf/progs/sock_read_xattr.c  | 54 +++++++++++++++++
 6 files changed, 187 insertions(+)
---
base-commit: 6b5a2b7d9bc156e505f09e698d85d6a1547c1206
change-id: 20260617-work-bpf-sock-xattr-37ec4c991886

