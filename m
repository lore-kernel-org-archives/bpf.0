Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF75F30CDBC;
	Tue, 23 Jun 2026 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230959; cv=none; b=Z39irX9sPf8DYBC/fmgq0gm7EFIh8dI7/uu1DoJSde3HxfzcSI6waz/84/eTgH7GWN1eipCpkEIbmWDpFCsB+GUK93sPlZKRnMYHlZz3IQr0/MsQXAxPvDSvrfYttiPndFyI28Wo0pn5ADX3JnObl8K55kYh72umc6aMQuCXOLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230959; c=relaxed/simple;
	bh=CInh8XAA2fhGHng22WiBPloY+8C8sPP8xHVrV0jplks=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UPu3D0/PEW7TS3is/m69WmjBhck4tdBHiDZOY6WkJru1758o8rjflbD+DRzOQshDS4fFHvZ8shRUfTqPoVr4Yj8xfOnkvfdDGmRDRX/q4SyTF5Lc5MMgoOIUzemjI9iDEuR3st4nrTwMbMM/BTCFfBN6ZBUqFOpxlFb0lMmJtis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zb8IXfwb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zb8IXfwb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4891F000E9;
	Tue, 23 Jun 2026 16:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782230958;
	bh=2PguWsrlG4iSkEVEQsCsbjDTmr4CughENgFDBtKEPs0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Zb8IXfwb8IV6Z09cqcfLOU3HmBDF/EznroGhn1/Fw0BaOITdZjBz9Jws7Nrbgi7S+
	 FJ8eFwBx1G/G2oOLVLO17n6JdS0o/XerVqlFjdf6PN5ez3dtBGKZAJrUgiVglFWz/i
	 NNHaoxosuTbPj06dtLmnjDcCNQdIDrXXygiOAq3k+gdfCGieIfEbVKUfZ9pMT1HPiI
	 f8mWRIbwj6ugVZL/khyULUScj0sYa2fq7WqKs5lf/4I7firtDcPQrDhbi+CIGd2DTY
	 OfJyAcGE/q13O/czDaOv+ZpsyJDY22BXLIH6/RnP+UCYSPvMRy+InkfO6E7NoIHF7I
	 ogYsDUFXzZLxQ==
From: Christian Brauner <brauner@kernel.org>
To: bpf@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260623-work-bpf-real_inode-v2-1-8e8b57dd25f7@kernel.org>
References: <20260623-work-bpf-real_inode-v2-1-8e8b57dd25f7@kernel.org>
Subject: Re: [PATCH v2] bpf: have bpf_real_data_inode() take a struct file
Message-Id: <20260623-meinung-herzrasen-gewarnt-e3a56bca3df9@brauner>
Date: Tue, 23 Jun 2026 18:09:09 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-5fdb0
X-Developer-Signature: v=1; a=openpgp-sha256; l=881; i=brauner@kernel.org;
 h=from:subject:message-id; bh=CInh8XAA2fhGHng22WiBPloY+8C8sPP8xHVrV0jplks=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRZrV/T+TiOyVs0XGf2FbMVc2fze03nNmE7/mHeWduTf
 160hAre6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIpgLD/9juP/c/mnPO2hF2
 9PhJht0xEQ0GMkkL3lk7qrldfDq/kJ2RYVdtWP1EoQ0WPdtqc6/q+k43/9FxvnJeSOm15VG/OFi
 M+AE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Tue, 23 Jun 2026 11:32:27 +0200, Christian Brauner wrote:
> bpf: have bpf_real_data_inode() take a struct file

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] bpf: have bpf_real_data_inode() take a struct file
      https://git.kernel.org/vfs/vfs/c/c99895a8cbee

