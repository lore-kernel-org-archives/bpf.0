Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A63C3B19C4;
	Wed, 27 May 2026 19:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911362; cv=none; b=PsUVtW8vhNTKi2zgWUNuANhlOs7LNifkgPf+loIeyEV0R1CeCogBG9veUvl3NyAT+d8EoELV/nTkf+zNdYAiSFoXsfoQ0dQMSJd6MbjZIE+KsqBFScL5OsL4axFBlmLDJXVCL8Dx+Lwp24+Oyixb4t1frqhiWjMQI0IsaaVyebw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911362; c=relaxed/simple;
	bh=+2/IF8/JJ0MfBQpgoL+K9NYbBdfrHP0u0VxQeTTYRgw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QfEL7dh6mDArvt+Z57N5C6Mg36nhpFaIgTApADPI7DDiywOnyKtwNQwtLYHzj8zXl33xZ4ecGOpTFYyrlCLmrkamnSmwhsVY0fKrxv8Ldr4x6hTn+TBczwJousZAtV1zDatQ1SR1ifBtdROwtM4r31ZZxUjHNyQfGVGA00sg+mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWIb2xZo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWIb2xZo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA081F000E9;
	Wed, 27 May 2026 19:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779911361;
	bh=jcVnpiKqpr3a5NXcIfBMM61Zdaozomcn7Ijfq9qQO4A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CWIb2xZoWpqOmiK+YO9T1NphkVjKZtG8w/LbcNuRAFhZN9tUsWV5t0c/NAMEClSLe
	 lhhYf0UA65DJSI8hUsThl9q5tUJCY1Pd3UhNdFXFK0ilA8Mydu3gkteRQTNuDDDy77
	 1FbxLaCrowzmZPBWkbV4k04fM11gQ37fuZQGmjg8kibxOXTUyCr9IuT7nAgTHWgOmy
	 IyxnGw9VWMg8Mho0YK/7Z9o3OHHy0MszI12QEYeFTdYWmH07Pedj0/oxekmCSycQ7a
	 LhQc1goo3J/ThiBfv/Q1hBBP8SqXA+kVVpX8G9wlmQm29eUES9i/dmZssW1DH/IPuG
	 1NETIkiG6XY4A==
Date: Wed, 27 May 2026 15:49:18 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: sashiko-reviews@lists.linux.dev, Dylan Hatch <dylanbhatch@google.com>,
 bpf@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>, Indu Bhagat
 <ibhagatgnu@gmail.com>
Subject: Re: [PATCH v16 05/20] unwind_user/sframe: Add support for reading
 .sframe contents
Message-ID: <20260527154918.5204c6da@fedora>
In-Reply-To: <7fa7ea0c-80fb-4a3e-abc9-8f3dbd7968b1@linux.ibm.com>
References: <20260521142546.3908498-6-jremus@linux.ibm.com>
	<20260521151811.23FD61F000E9@smtp.kernel.org>
	<7fa7ea0c-80fb-4a3e-abc9-8f3dbd7968b1@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 May 2026 11:26:00 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

> Previously (see v15) the code was using user_read_access_begin() and
> user_read_access_end().  IIUC scoped_user_read_access_size() is just
> another mean to express the same and it behaves the same.  So if the
> issue brought up by Sashiko AI review is valid, then it would also
> exist with the previous implementation.

Note, Sashiko's reviews are statistical, which means you can get
different issues brought up by running it twice on the same code.

-- Steve
