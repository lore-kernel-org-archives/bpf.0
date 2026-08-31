Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2428C3F23CC;
	Mon, 31 Aug 2026 09:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168247; cv=none; b=mjHZsOANGLM07O8RMKARkoWkFvwVsc8dgssoKQo5TiQPDygHVjDM9A3s8EMrgwz0wBboFze142F8oMEKQNBuz96//siAvDiUPLcvR+sC6RWpBIY6X3IS5MUIFZeZsnnmJ6z3BlsZhZ0pfE5u+Fla7xCjCJqyQCQuEVItPrQMFc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168247; c=relaxed/simple;
	bh=V9T8VDVdRMnEAKDqpC1OU4TSbC6nATuy54OGvnGpEEo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mKlP3rIYaD8f91JZRQIcKWVGoFdhFcO4bsKxDK/8oFcTZtNlWzmd+8Hnp33SpTH/SqyZpdTJHATR9hiNQ8ParbtNxioNWS7agRthf/b7LePt39lhXLrCB3Wf6qzARIpVdSakbbod4hEiLjxCRkAplAGWRlzfg/DaUp9DUFiZJ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zp/XnEB4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zp/XnEB4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931CF1F000E9;
	Mon, 31 Aug 2026 09:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788168245;
	bh=JTYK1ojjw3yWvUiI7I4jDJxXxC1gQd5K8/sNtqlgGSI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zp/XnEB49y1xRCDWGlmL5AznmcJsdRLYJME0h15+HuGXRwBQUEZ4CcMcf/FRPW00l
	 0U1Hho2Dbav4hfMO2DUec0XqfXs0FMfhVWICko/lWp7E+Owbyvscu+nwuVqHG6/BH8
	 0lKYNbZ8Rf++XQqaCBmWZevLU0tzctVf8Apau4vj3ut9+BNfs6PuTAxiORN9Ha0e81
	 SRtGDoKiPSXQfz7qHjopIcChZv5L90kXF4T0uplWZrzGEOjmuSRrGRWJNf0Dt0eIxo
	 /CDX1jNWpZS66iRTlDpBC7uzzVmtFdcasgY4wEiqIrStd8LgaewD/yYy9w1PC1fpTX
	 zbecQXy/OW+3Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 06/20] rv: Add rv_get_monitor_by_name()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gabriele Monaco" <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260831090524.106845-7-gmonaco@redhat.com>
References: <20260831090524.106845-1-gmonaco@redhat.com>
 <20260831090524.106845-7-gmonaco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:24:05 +0000
Message-Id: <20260831092405.931CF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] rv_is_container_monitor() fails to identify an empty container if =
it is the last element in the list, leading to a NULL pointer dereference w=
hen enabled.
--

commit a8e1e1f414fc69c200ed8ba3fee4d10346fe86df
Author: Gabriele Monaco <gmonaco@redhat.com>

rv: Add rv_get_monitor_by_name()
   =20
Add a helper function to get the rv_monitor pointer for a registered
monitor given its name and add its first user in rv_register_monitor().

> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index f77c5865f41ab..33919c5fbd6ad 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
[ ... ]
> @@ -229,6 +230,18 @@ bool rv_is_container_monitor(struct rv_monitor *mon)
>  	return next->parent =3D=3D mon || !mon->enable;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but there is a pre-existing
issue in rv_is_container_monitor(). Does this function incorrectly classify
an empty container monitor if it happens to be the last element in
rv_monitors_list?

Looking at the rest of rv_is_container_monitor():

bool rv_is_container_monitor(struct rv_monitor *mon)
{
	...
	if (list_is_last(&mon->list, &rv_monitors_list))
		return false;

	next =3D list_next_entry(mon, list);
	return next->parent =3D=3D mon || !mon->enable;
}

If an empty container monitor (which has a NULL enable function) is the last
element, it returns false early. This bypasses the !mon->enable check,
treating the empty container as a regular monitor.

If a user then writes to its tracefs enable file, rv_enable_single() appears
to unconditionally call the enable function:

	retval =3D mon->enable();

Since the empty container monitor has a NULL enable pointer, will this lead
to a kernel panic via a NULL pointer dereference when enabled?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831090524.1068=
45-1-gmonaco@redhat.com?part=3D6
