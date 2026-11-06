Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793954191;
	b=IKvtvhLvYD1A+cWSuWgihb9owyeLiZeG14dCm5SUGbhZdIB3X/ECyLP/nnDaJmA6iSDi
	 /Kzpm78OKEEkIy3jeqvp3JJKKtQW63iX1XVoJtnHP119kEMVudLvDgzepCMoP/OEO3lyZ
	 qFZ6044BSvNmJ7cu5sBEVs4XAiEEvN2SjE33rmkAo1oaYC2QIv0JkQbGuCQo1gycYmTg0
	 dGHKNWry4JVSez8meWkj4rFbs29RIe/2hu2dFjhru5qhZIHD03pmQgjTPqOvD070u6ZIS
	 UU2XU2Ba4NIQZmoaX62X7qS/ywWXAdn7Ffvemku+T09X0ztypI4j4QzxqYd1s6c+9xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793954191;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zz7+tigRnrTgKu877dYVqG6h8sn1p3+JJhieliYWKd8=;
	b=Q4dtSZAKMGviqVrSdXtIwCy049o5G6EK7kbokIBp0ha6+3qSp9kN/pRjJvVxp7joiCa2
	 Nrq2W6D6yDO7Exmkj6ENtW3ULE1yT6uA7YX9UCtKxDQp9PRJ+Ay7P5SHMnvMsJlCRnDj4
	 62S/aR1tOpRxowrd9kcU6DSHMuCgrXQpbvWuhZJ27FR+H8gpCZYaJ1CmbmoOQIx3NSTF6
	 8vezcHRTKXviOykE2wxWVUy5wzeR1LiD2pQgqrMDM9WN+X60iaT4FxYEs8X+FYs97IYgn
	 hQvlK6Z4ystQdkzuKg5t1rQ1Ft0aNCvso0jzjNZPbodNT8wDMp4d2xwKIshQAf8ming==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D1ugBaxl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4FD606A339;
	Fri,  6 Nov 2026 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D1ugBaxl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94F51F008A2;
	Fri,  6 Nov 2026 08:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793954190;
	bh=zz7+tigRnrTgKu877dYVqG6h8sn1p3+JJhieliYWKd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D1ugBaxlZj6W3xTpPRBh4oQ90EAYL+HNmcE7vl131/UoPZQvX64xnAzustE/Pja4z
	 zlmLFarGwqsK5GXVNacLCjI6Nba7lMsY/D3Xwjle/k6ca6Xmb0lSPx43PmSJU6Iryp
	 QE2B5oQT7O2shRWIt8Wz0eE9+6SGTR2AY6yojX9RgTq5IJ0XoQdSvRJhfml6ZQFHSc
	 B65Qkkh7BMJV+4Wlya6yTYIXfoy82uKnVViQGIZQKcKuBoIccZSs4WACJGFp1F2UzT
	 zLMWtbvoKSaicJVj3eYqYcWvBrq3eYT1xqdM9Ep1G0zuy5GEW7P0fqTnY67HzFM9rK
	 nZViMUQ+RFZWA==
Date: Fri, 6 Nov 2026 09:36:24 +0100
From: Christian Brauner <brauner@kernel.org>
To: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, viro@zeniv.linux.org.uk, jack@suse.cz
Subject: Re: [PATCH vfs-7.5.bpf v2 1/3] bpf: Add bpf_path_getattr()
Message-ID: <20261106-nachjagen-kennt-wehmut-3fac7c2139cb@brauner>
References: <20261102104655.70901-1-tasos.papagiannnis@gmail.com>
 <20261102104655.70901-2-tasos.papagiannnis@gmail.com>
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
In-Reply-To: <20261102104655.70901-2-tasos.papagiannnis@gmail.com>

On Mon, Nov 02, 2026 at 12:46:53PM +0200, Anastasios Papagiannis wrote:
> +	ret = vfs_getattr_nosec(path, &stat, request_mask, query_flags);

Hm, do_statx() filters both masks before they hit the filesystem and we
should do the same here:

	if (request_mask & STATX__RESERVED)
		return -EINVAL;
	if ((query_flags & AT_STATX_SYNC_TYPE) == AT_STATX_SYNC_TYPE)
		return -EINVAL;
	request_mask &= ~STATX_CHANGE_COOKIE;

STATX_CHANGE_COOKIE isn't innocous... It causes generic_fillattr() to
call inode_query_iversion() which sets I_VERSION_QUERIED and forces the
next change to bump i_version.

That's in-kernel only. A bpf program shouldn't be able to set it on
every inode it looks at.

> -/* Side-effecting kfuncs that stay exclusive to LSM programs. */
> +/* Kfuncs that stay exclusive to LSM programs. */
>  BTF_SET_START(bpf_fs_kfunc_lsm_only_ids)
> +BTF_ID(func, bpf_path_getattr)

I don't think this belongs here. The set exists so binfmt_misc
handlers can't modify filesystem state. bpf_path_getattr() doesn't
modify anything and the binfmt_misc match and load programs are
sleepable. So they can use it on bprm->file->f_path just like
bpf_path_d_path() and bpf_get_file_xattr(). I'd drop this.

-- 
