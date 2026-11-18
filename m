Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012923;
	b=GIM9/PoxbEcPucdMluKoiEPqmR+lKfhRmJ5KwUBsxs8vvaQnAqgp6nBfHN7WE4niu1ie
	 YOy4nRb2tHPHCwBfqJtBFYnh4rPf7vR8wa5wRUURt+cDiyloPl74en7FhFJ81xHbInbXQ
	 8vq/o5sbJxgG0n7cFjrtoPU3XDrRJCOO3BsKMxDdGgysB8bw36NH68evME8rx614wsElu
	 Gx8YUIGEBDINi7Rfym5e/pnh80+rZ0TsqE+PzFL6mY/Ykd4eVJ7Q9IrjaGjza99zvszvt
	 r2OM9zNf+cRXVC5nsFpY5IvPjNT5JTqUM2F91dspob8HPKSbE2m2d68886Q4EpjvLCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012923;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ui9bwqcR5iRZMs0bk4vDHQb4W+wmXCwkTn0lXdN1dQk=;
	b=jb2C3BDKkLSjzSsv2dsBaOneQPa9uzCLqhFeIQ1sjZjkgIsI3Om+6WatkqkAQ459PhwY
	 T4HyulvA9ZW6fKjAr+kMfia91gb5I4ket9gf3gKv0/XsR4IRgbt1afSU+LNNkXm+dxoFo
	 1K8EDseTkkcCtSx/qQmvV2h3tpCxdKURmyZOVqsr/fzdAQRiZPBqVCHypPY9JJ8mKVAsk
	 rL5YYLmWMRGYc7x9/BzuxJydgoL0mxBoQd7nzYvZoaFTucOz0HnAG1y8uRolzyMUgW4tH
	 utaBkBbIb+eBbCBK4X4omdfTXZ9W7LV2+P6D/wFk/p1EletNcNUSS2O9NPBCHKBAayw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SC5dzHNx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348E8606A31C
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SC5dzHNx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE931F000C9;
	Wed, 18 Nov 2026 14:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795012923;
	bh=ui9bwqcR5iRZMs0bk4vDHQb4W+wmXCwkTn0lXdN1dQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SC5dzHNx6cZUEJLFsCDP4cloWYlMIfo5/TWPhxWU2vMNBY23bcZmo1RjG4Hlc7BvL
	 Oc3+0yk6dOu9pKaI96cLphT8YlE/ii7VK0/AeNWS7XLXMw12oT/5KmA5pFRCM3ypii
	 u0i2cF600G08LCiwm/0F1k/qDKCWmtbfptLstgA8V7Xjl/dPBHTTkSg3wxOwYJ7lVj
	 PlzRe7ovxaBjULKbyEqs0X4V5HHi3n2zvV1c/Sx35BCpib8W6YvgbyVhx2TocGYYFZ
	 49qtP4nz7KX1jNobRLhss4Hn17rTLzseTl63ShsILf9VpbuxfQGb27VCWn3uuJT0RW
	 eogAR5IhNMzEA==
Date: Wed, 18 Nov 2026 15:41:57 +0100
From: Christian Brauner <brauner@kernel.org>
To: Justin Suess <utilityemal77@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Song Liu <song@kernel.org>, Chris Mason <mason@kernel.org>, 
	Xu Yunxiang <xyx2021@mail.ustc.edu.cn>, Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/5] bpf: Don't apply the trusted field lists
 to an RCU-protected parent
Message-ID: <20261118-abkaufen-gelackmeiert-ekstase-0dac03c1cff0@brauner>
References: <20261023212041.884996-1-utilityemal77@gmail.com>
 <20261023212041.884996-2-utilityemal77@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261023212041.884996-2-utilityemal77@gmail.com>

On Fri, Oct 23, 2026 at 05:20:37PM -0400, Justin Suess wrote:
> untrusted. Add file->f_inode to the __safe_rcu_or_null list: inode is
> RCU-freed, and struct file is SLAB_TYPESAFE_BY_RCU, so a file read
> under RCU may have been freed and reused, in which case init_file() has
> zeroed f_inode. The field may be NULL and programs have to check it.

Nope. Inodes aren't guaranteed to be RCU-freed. pipefs does:

        .destroy_inode = free_inode_nonrcu,

and very very much for performance reasons. Plus, destroy_inode()
returns before call_rcu() if a filesystem has ->destroy_inode() but no
->free_inode().

So a pipe inode is freed right away. And because struct file is
SLAB_TYPESAFE_BY_RCU you can read a stale f_inode out of a file that has
been freed but not reused yet. For a pipe that points to freed memory.

Filesystems don't guarantee this either necessarily.
