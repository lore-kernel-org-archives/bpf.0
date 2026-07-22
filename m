Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C194D3264D8
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 10:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784717348; cv=none; b=H0qJ40p7PsmFbBycgWwBszZf9QInIEQN96eCSyWj/IROQO527mNQKo5IV2yPt+T+/NU9LKKeZNrubXw8ygZMcNAILDhUphtrMWl6ehExp+Zpm2cJTJMRsxxOpx/uJwd8n6oIdBa0z3I3kisiuEDLuSY2MnSIFhJYHWUkuijjksU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784717348; c=relaxed/simple;
	bh=n8t4bF7Fxfm+7++EC3O8cOcIv8wk285xa1vOfNYEORY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MtA11EKmHWc4gKzkCtZzLIAmA8F9DHAqnsoVb+yTQbY4atl08OvuNojN69hGLzaowe+/J1/7YyXJwFf6u0lXzza4D8lztcbDYwgUFhFGClK0A41VrdJeN6IPZDFz4Aq9BAnMlk8r/eZeEfLky2ijr45jKa/Qv18u2V+tayZGXuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOtiV131; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOtiV131"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C131F00A3A;
	Wed, 22 Jul 2026 10:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784717347;
	bh=JJHxeKRJT7CkC1fYW3iJebrFs5aatmpqkqrZ0dlHIOM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BOtiV131BYRLRnuW2S/dOwyvVYtvR3GZgT8bPjNVrY+9MjRAS27qNllbq1IEHBD0a
	 AN6xF0qG2sUbxp4dT/nyGSFmW7hmfWJVKzO8yHDbKmUeO8onArkJbnEQmrrtjzSEs1
	 gWvHaqFU+thFJseGnX6D+0Zp3+zvNuGa7xpzcENgEOL1QCYBmHCN3VCzfPmzi2gcYj
	 dzh34sy9MV7Igyap427DQ2Es9XPOJDsSeOMy+rcA9533V4g+V0e5ThiT79Ilq4+c1Y
	 QEZ3rAK0OzTy8oKdzbAoJ9WGoMgjnoYAN0kVpH6A5OsCzCrGV6NVytSR4d+fLXL1It
	 ZUMUzwbQQhxOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/13] media: rc: Fix use after free in bpf progs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Young" <sean@mess.org>
Cc: bpf@vger.kernel.org, media-ci@linuxtv.org
In-Reply-To: <ef00c264d0ead1324c4d61bbb3b1a4b2dc5bd4f6.1784715737.git.sean@mess.org>
References: <cover.1784715737.git.sean@mess.org>
 <ef00c264d0ead1324c4d61bbb3b1a4b2dc5bd4f6.1784715737.git.sean@mess.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 10:49:06 +0000
Message-Id: <20260722104907.27C131F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] NULL pointer dereference in BPF LIRC operations due to missing `!r=
aw` check on device registration error path.
--

--- Patch [12]: [PATCH v3 12/13] media: rc: Fix use after free in bpf progs=
 ---
commit 7dc21e94d34583cca33adec11dc3c1b8af880d26
Author: Sean Young <sean@mess.org>

media: rc: Fix use after free in bpf progs
   =20
Since commit dccc0c3ddf8f ("media: rc: fix race between unregister and
urb/irq callbacks"), rcdev->raw is no longer set to NULL after device
unregister. raw->progs could point to stale data.

> diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
> index 2f7564f26445c..14ab611e74457 100644
> --- a/drivers/media/rc/bpf-lirc.c
> +++ b/drivers/media/rc/bpf-lirc.c
> @@ -148,12 +148,13 @@ static int lirc_bpf_attach(struct rc_dev *rcdev, st=
ruct bpf_prog *prog)
>  	if (ret)
>  		return ret;
> =20
> -	raw =3D rcdev->raw;
> -	if (!raw) {
> +	if (!rcdev->registered) {
>  		ret =3D -ENODEV;
>  		goto unlock;
>  	}
> =20
> +	raw =3D rcdev->raw;
> +
>  	old_array =3D lirc_rcu_dereference(raw->progs);

[Severity: High]
Can this lead to a NULL pointer dereference if rc_register_device() fails?

In rc_register_device(), dev->registered is set to true before lirc_registe=
r()
makes the device visible to userspace. If a subsequent initialization step =
fails
(such as input_register_device() or ir_raw_event_register()), the error path
calls ir_raw_event_free(dev), which frees dev->raw and sets it to NULL.

However, dev->registered is never reverted to false. If a concurrent usersp=
ace
process opens /dev/lircX and calls bpf(BPF_PROG_ATTACH) while the fd is kept
open, the !rcdev->registered check here would pass. The raw pointer would
then be NULL, causing lirc_rcu_dereference(raw->progs) to crash.

[ ... ]

> @@ -186,12 +187,13 @@ static int lirc_bpf_detach(struct rc_dev *rcdev, st=
ruct bpf_prog *prog)
>  	if (ret)
>  		return ret;
> =20
> -	raw =3D rcdev->raw;
> -	if (!raw) {
> +	if (!rcdev->registered) {
>  		ret =3D -ENODEV;
>  		goto unlock;
>  	}
> =20
> +	raw =3D rcdev->raw;
> +
>  	old_array =3D lirc_rcu_dereference(raw->progs);

[Severity: High]
Could the same NULL pointer dereference occur here in lirc_bpf_detach() if
userspace races with device registration failure?

[ ... ]

> @@ -316,6 +319,11 @@ int lirc_prog_query(const union bpf_attr *attr, unio=
n bpf_attr __user *uattr)
>  	if (ret)
>  		goto put;
> =20
> +	if (!rcdev->registered) {
> +		ret =3D -ENODEV;
> +		goto unlock;
> +	}
> +
>  	progs =3D lirc_rcu_dereference(rcdev->raw->progs);

[Severity: High]
Does this code also suffer from the same NULL pointer dereference risk on
rcdev->raw when rc_register_device() hits an error path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784715737.gi=
t.sean@mess.org?part=3D12
