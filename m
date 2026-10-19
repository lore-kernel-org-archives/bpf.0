Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444211;
	b=3MGlM+/FalMnOwGd87Hn4sbAoXxX2TdVOwDXFpATDP7UcFB8RRzLmAts6AjZBexnJY5m
	 9Tzbb8p8MdWQ957ZxLAK5JnqphzRwFjq8cO6CdiyTv7ipKGX7vANaByKVv7V98O6dVB4O
	 7/to/xl9hc65wrPq+EDSe/79dbick3S0yzQ0+1mDOD5dX93ceWvdaBn2HkM8Z9r/u9boV
	 GGbEwB7YOckbJOirtJqjKhTNo+4B+G8RnRInJodJtpYEOfhzqlYbL18dcOkEdabgTGxxf
	 r/9jLCfFoksggP2eQnu0zd9qa6GvN+zwobugfzkG1zU+Twy30lV16oOHjqxqmpxUryg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444211;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qH1QT2yPQbf9QMked+nvZ1rom5Sw5Y/oVMaXqHSG0RQ=;
	b=1J6okaQwLCv9gWek+huYT7ZirpZ4+Mz6TCBhfTMp7ERuIhClepFNvh6zfgbjm39ToQQp
	 UroNw2MVvhvVkTvAzK6gRbZeFUjcNe8emJZ1bTSdRhR6fIL3cNiVQggs5oBE3E/dXCxb+
	 nqWQvrRIxHOe+DwVrkFG99tDkekc8KCrilz4OLGJY8gUKFG2rgx9wAMLc6t+CS5/raRWO
	 76O/HkvZ2E5oHDbSY437AsH1bwHl0dvgVnM5qfdTyLSUBGkw459fmFptFSXplzld6JAw9
	 2bpsqZqFfPG1l77NhK6ikLOFcuXiEkUusDfZQIFrK0zRB4MMEbOu3EEUtTPCR80FIVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mgyCx+TA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944F7606A319;
	Mon, 19 Oct 2026 21:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mgyCx+TA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CEC11F000C4;
	Mon, 19 Oct 2026 21:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792444210;
	bh=qH1QT2yPQbf9QMked+nvZ1rom5Sw5Y/oVMaXqHSG0RQ=;
	h=From:To:Cc:Subject:Date;
	b=mgyCx+TAuthh31Uj4+90fowTinjkQvqQvEUq7z1DLkaDVJUjx2QpDvnms2UhiBXT/
	 in/NkxN+REIuFRvpqCz/9/HDCskNFYQsQsXYQN+VBw+UgkJuPvDGGJnMHE5KK6u02x
	 23I4c5856pAJaDRvVn7DoVYylVQT8HVn25Iu4YJgblpdg4G3z3aggQn5rZBuLvb6eb
	 0KJTbXyZoRqFKLSucA66Y6pQp2TtVqB/VXME432u0v/PwO18kXj2XVI0D6+ayQh9g8
	 HeW6sStYOmHHf1XIKErquW0xP9WTJEdbqgLCXo+2oTV25NnW8qCXllXuKur4pA5kEp
	 FOReMNsoNLTmQ==
From: Sasha Levin <sashal@kernel.org>
To: bpf@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Eric Dumazet <edumazet@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mahe Tardy <mahe.tardy@gmail.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next 0/3] bpf: Fix builds broken by fatal resolve_btfids warnings
Date: Mon, 19 Oct 2026 17:10:03 -0400
Message-ID: <20261019211006.2574350-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 201a454df948 ("resolve_btfids: Fix the --fatal_warnings exit
status") makes resolve_btfids warnings fail the build again with
CONFIG_WERROR=y. That exposed BTF ID references to functions some
configs don't build. KernelCI has been seeing i386
i386_defconfig+kselftest builds fail on linux-next since next-20261015:

  WARN: resolve_btfids: unresolved symbol bpf_arena_reserve_pages
  WARN: resolve_btfids: unresolved symbol bpf_arena_free_pages
  WARN: resolve_btfids: unresolved symbol bpf_arena_alloc_pages
  Failed to generate BTF for vmlinux
  Try to disable CONFIG_DEBUG_INFO_BTF

https://files.kernelci.org/kbuild-gcc-14-i386-kselftest-6ad2315ca3f195e1aa930c8a/build.log.gz

Patch 1 drops three special_kfunc_list entries that have no users,
bpf_arena_reserve_pages among them. Patch 2 makes the remaining arena
entries depend on the condition arena.o is built with. Patch 3 fixes the
same problem for bpf_lsm_socket_sendmsg in bpf_ksock.c, which breaks
x86_64 builds with CONFIG_BPF_LSM=y and CONFIG_SECURITY_NETWORK=n.

The entries left in special_kfunc_list resolve to the same IDs as
before, and the IDs that become BTF_ID_UNUSED were already zero.

Tested by building vmlinux with CONFIG_DEBUG_INFO_BTF=y and
CONFIG_WERROR=y for i386, x86_64, and x86_64 with CONFIG_BPF_LSM=y and
both CONFIG_SECURITY_NETWORK=n and =y, and comparing special_kfunc_list
and bpf_lsm_socket_sendmsg_id before and after the series.

Sasha Levin (3):
  bpf: Drop unused entries from special_kfunc_list again
  bpf: Don't reference arena kfuncs when arena isn't built
  bpf: Fix ksock build with BPF_LSM=y and SECURITY_NETWORK=n

 kernel/bpf/verifier.c | 11 +++++------
 net/core/bpf_ksock.c  |  7 ++++++-
 2 files changed, 11 insertions(+), 7 deletions(-)


base-commit: 25bb03f0a47b622b9025a1558bf2095ec1f55d26
-- 
2.53.0

