Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB8F491583;
	Tue, 22 Sep 2026 19:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105687; cv=none; b=H9eN7TBvDClBbsRuMGrTseo2zoaN4RRKkGwovNwrm3clBl/79yw1DfXuxsPLg2cZyzFQsGY5w9v4c/p12GuYx6adTFDASXjgBzEOrOdZGHbttm6cxhJWhuKBoN3ftAvBcGpj7Jo2ezKgMvOMoYUaeGGg9rLN48+47cMWjg75NdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105687; c=relaxed/simple;
	bh=noPPqEnBv+nr4edOfoC8AoQBqjTSYxJ95+eG/Zl1rXU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nbrRzWfUq5IPb1I1mWQ2vKsOiMU/pq51gAAwtloQTOgmjB30ZDt2fWk2yVVPfGx6bv0+lz2TtCcORt6ZKgr6uIFZkQPN+jpAK5d9D/GnwwQAW/sASN9a7QvN2LX5RYFw4C+YdxAkWjPms7YqvNFw8rTwAj+FgUISBwuUMrmFFXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oY2xxW59; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oY2xxW59"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0247A1F000FF;
	Tue, 22 Sep 2026 19:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790105686;
	bh=noPPqEnBv+nr4edOfoC8AoQBqjTSYxJ95+eG/Zl1rXU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oY2xxW591flde9/VfDbs1Z9bTCezVdgg95axWi1mVx/9qhWmSJ7T3kNAw6ADmRqWG
	 bsoWoX0oDudhORTvZ/gKVq6ILAPFBqsCyA+0smUTalxVAu9pBa9NiFVRsBclBix0cC
	 aMV53zH8QglQ+hfCuiu2Luhrk+jr+oRFi2oy0R7WywfA/fZjCMNJsOwVQoSaXuVkrY
	 WRBYrKyQJ/rPCsQpp0HffraLTzwfX8jSr4ED7uDUah3zZcMkzloWbGPBRBJ+3QlnCz
	 zABFjDeDhMDx6Ihb8Sm8px5kuuztW1fGgpFXJQvg7QtdJ7NV8o4MgOPNtXvH4W+huj
	 wHtWkLZUXfDXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/14] um: pass pt_regs to audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <c84739d9254fd1398840d907e525eaac648b6e17.1790088067.git.rrobaina@redhat.com>
References: <cover.1790088067.git.rrobaina@redhat.com>
 <c84739d9254fd1398840d907e525eaac648b6e17.1790088067.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 19:34:44 +0000
Message-Id: <20260922193445.0247A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

> audit_syscall_entry() now takes a pointer to pt_regs and extracts
> the syscall arguments itself via syscall_get_arguments(). Drop the
> individual argument registers from the call and pass regs instead.
>=20
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790088067.gi=
t.rrobaina@redhat.com?part=3D12

