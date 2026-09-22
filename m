Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2901C33DEC2;
	Tue, 22 Sep 2026 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105434; cv=none; b=Navkl7gDIFvrnjZQgc6sRHDeShuo/SgZoWQUPKeo+yBnBx4flDi7O9ldr1P1Fmq/IOsK1BfuAUXvlr+BiHkt5qI0+HvnlW/fa9UIkcBGlL+L2QsSR0WdEcDBvQ5kmKGlGMPZITUKwA5LZ+H569Gklg2dv3V3K87e4Ipr6qI1n2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105434; c=relaxed/simple;
	bh=+zD6ncHl77luTQsViex3RFLBOIkKzO9K6k+oaa15fwY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NVCickY4I8XL+PpQR0DudKhpI8LJCVA9OU8Y0tMpcuUez9NCvbJeeMLK7klSyAFImF+O6RJvWPZ7E4+KiHXbRj+usK4/CX/liCORZTIpl0xK5wRsyJrntSaT93Pest6yCa6w0sjwKsR3ibdMcvBxmDYzOtWXjSXN491QDgtgiSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPOd7JFd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPOd7JFd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CBD1F000FF;
	Tue, 22 Sep 2026 19:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790105432;
	bh=+zD6ncHl77luTQsViex3RFLBOIkKzO9K6k+oaa15fwY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iPOd7JFd9RDwNDNdrpj89tiINmoN1pr3AeQNyc76r/wvfYoJB04Lcxrclx/G9aR+i
	 x01F+M8iHmFXbZPbhI4qqHcvRKZycwN7757u17wBOr6C77c5z+85JK5g/jNHekrnH2
	 D48XyBWhTXOneXw8BA2/QFzSpYXaOy5xk/jPxiOjejHKD3vxmjJ+7RjsQX7738jjze
	 bZl82sqPIxTMJpuF23UH/QMtlW7EAP+JUu+rt24pQ0+FR9FZjpzDlwYhWk4ozkjTIY
	 Xd86pJN+KsXyYlXh0XbAljc+F0C1PDtWMYcTdI9U7s+XHNm1HQWfZnV+e9jT/Ouqz2
	 lsn/2IqeKQXjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/14] microblaze: pass pt_regs to
 audit_syscall_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ricardo Robaina" <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <8bf782579aa4e549f201e67856600b4a3445ad66.1790088067.git.rrobaina@redhat.com>
References: <cover.1790088067.git.rrobaina@redhat.com>
 <8bf782579aa4e549f201e67856600b4a3445ad66.1790088067.git.rrobaina@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 19:30:32 +0000
Message-Id: <20260922193032.76CBD1F000FF@smtp.kernel.org>
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
t.rrobaina@redhat.com?part=3D5

