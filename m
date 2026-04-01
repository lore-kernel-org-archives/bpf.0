Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531613EE1C9
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 22:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775083573; cv=pass; b=tm/53W8do6oysqHuguzZqIPjtgtihASw8K6VeEGqb3hYD5+p5CoR9kEJV9+hazW4Os1cSFfoGO/tX5pq7cqf11nVoTCUABemzytj3HOuKIX7A5opKjgyi5v/6KCAkclhKwnrC9zRiwxDvuc1563eNEDqSl9ObIgCbz3pCu9uMK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775083573; c=relaxed/simple;
	bh=yoKsBPpPhR+NlzJdW07NGJsybBN0qe9g8BjIvDfIdh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iL6EV7DeG7UK86l+hGBCROtbKvVkby/hZkccfRw/C60UxTVPC7I85176vvsbnNz9YXUcCnaSeI9vwse9suOaGdruzIl9fUzzCTESVvTzeS3Mh1/PSlW3RdfhzDJao3gGbzFuPsKvljmZD5peWKdPcijv+luAuve+nJ3HiFPT2fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6/4VhU5; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6/4VhU5"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-43d029f346eso249216f8f.3
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 15:46:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775083559; cv=none;
        d=google.com; s=arc-20240605;
        b=UCg8yyAxOYHH+P9IForVdYBmR92krgdinhtt2/WhTRimSUXb4swo+GWlSGLV8fL6/w
         oLroFa0aYmeIVXIC8fl+zj/rue5ppNkwvMKhzMY/nVxVDgUP+e4VdqO/8HerTaxA8zvi
         SUnIhpzEiKdCXMBugj7RxlivWoA1PZcOZX4lKbKd+fKZWDpgjl8KfR4U0RETxIhCk/EL
         SJ0N8W3kICr8HZ5mVZ3Yhupxjjzi6VtL6CIxLGlAFIsQ51WBT84TLpnqAdjGWGb2t3Zu
         5kXw/gf2BAonUQhXAhKGpbWBroMIS9infrwfE+/Dlk9JPS7/+aqddgH3FuuR9CP5DQOn
         splQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ADfyEQKl3tpwiQcUBN/SGYqRNQVzR4cZLBHrcXxZk0Y=;
        fh=xXic0xAHLcwU7kDOcaY3GqEE5WNZQpk4Po888tN4jR8=;
        b=eYtMCDlMPse8SMnF/dwscGHV02zbqp6I15QZsZKOPo6qoMi9NGtStvpViZHPL9sb4g
         kWaBwDSbzcDTCRA48phgkFPr5XQfMfTBrwYFc77rM+bd3iKjS1yJEXdF7EkZ1adM+Nrw
         vmYMxTtlnSmgf4NYUeb3GrjnEdlV+mhhPGibW0wvtgYUuAyPwinuLogQOoHqmI5NXxOe
         Pq8XCVNlYV70/f1YZPtBUa8S5F2LZIa102fsF3TevLFJXrUwYfpeGBWKdOM4xQyuHcCU
         QEvWLnS37L74WSX0l0gR2Vy3yd7wWoslrBx9VWU9JKe2qW/RuTyRo3jaw9L5QSdPYEaH
         Rqrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775083559; x=1775688359; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ADfyEQKl3tpwiQcUBN/SGYqRNQVzR4cZLBHrcXxZk0Y=;
        b=C6/4VhU5G3hReiBiVGlVp0308KZ4tpOTAssO5g+Y9IhhE7Z+vsyyhInVia1AsghBFl
         BaMI5wRTny+f/c4e68/FBSlqGH4XGwF+ra2YNOgo7y2sfVbgtAs+FyXHIFmXBGxYizbg
         QJsrwsI4WJLFK7KyAly6hGHjVQvbyXlCLlHNW0KLTFALxGkiqwK1U151AR0zIi6k1vjk
         f5F8fX3epeeqqie3rcfaDaHXpdL1W2Iqxhx5DflBcfIcalYk2/k52lMpb3olVnnNzxM1
         jukcmVq0c5WcfA0/Gd93OIc0uzqf2G2wQTvmrPz3GSsNBm9W0amuZ6dNVBhmPSmZjsIJ
         GW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775083559; x=1775688359;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADfyEQKl3tpwiQcUBN/SGYqRNQVzR4cZLBHrcXxZk0Y=;
        b=amYA/zf3iLk7tbKXIq7uuKTonrSmZ6GK9Z7HddAI0qE7X0+aEO2jmnHvNdlLjEX6As
         9y6MNx4AMLP0G8QtJZnMrwyDrkjBz+2l71xgYe2nq4Ry1HlNKw9N1EFDsru+CmBJyGAD
         j06plZ9zxfxzz2bJg1TY2Q+ZfcRsAy8wxzaZ3g1gz/Y58wPXlnhenkmVvXHH23AMMDhi
         96lDQwGFEz+0mNqh2conE+C6YdCpss8ojZNK3b3wJp2nEoN0wnWHKim+nkPY+JaGxolP
         fdKbplx95TEVgvRWoYCH9SWGlgL/mHKFDALFj6fFPa4VinqVeqoqOaGpDh0i++7GcE3p
         bRUw==
X-Gm-Message-State: AOJu0Yww4nGfNen4Khvn6+SVsa9zkH5NZeFpMZUoorEhmTDJAgU/VFZO
	RWYHG8lWbthZ9N3EPcARZMH0QitUWthFwlI+j1XpdY22u1yVTBGQK05aD0fKwDP8lGTzCmXLjwK
	6D3wBMfpLQO18BXfojIT7iYxx8qwsb8U=
X-Gm-Gg: ATEYQzz7JWPKti/lTg1lpUX8NpuE/SXfN7IcRPPLok8uhbX06WCKj1PRsOLtiU+gIWk
	cbBQH7UhNQZ/jwonZ+CUZJBP+aP19N6drptr1Ddke2DrJDPsmBlOREUMlnJmSUncXCg5bBfL6US
	Q/ZZF6rDtIbnmgy8+sSITIvNeqzk+t0x3NGKBSK93D4oFx9XgVNwpQnNLo3OR1ugdF1+vKjPVPy
	vtnZaJprb77vaOayw/xiEE3f5MsXWiqfwtilSmqV1MPsUlFp7gVVnrJ13hzdHZJp/nCfyEhlNys
	38q27DP0v095ZMEJF6Bo342YpRXKMEJB3HZPkoOy2B3rznFzX5OMI2XwPQDWSW96qZMcbQ==
X-Received: by 2002:a05:6000:4009:b0:439:c18f:5aaf with SMTP id
 ffacd0b85a97d-43d1f25aa0dmr1879240f8f.34.1775083558432; Wed, 01 Apr 2026
 15:45:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401191126.440683-1-varunrmallya@gmail.com>
In-Reply-To: <20260401191126.440683-1-varunrmallya@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 2 Apr 2026 00:45:22 +0200
X-Gm-Features: AQROBzAz8G6KDlX_EpiUXFkOb-GbK8pH-ZY0h5VhNGUNmRhQFstxQ8m8i5dLXD4
Message-ID: <CAP01T77q=ZRTbA03qVb5pdkYg6FJujLts_qa+t9FX46bDecxfQ@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: Reject sleepable kprobe_multi programs at
 attach time
To: Varun R Mallya <varunrmallya@gmail.com>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	yonghong.song@linux.dev, rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Apr 2026 at 21:11, Varun R Mallya <varunrmallya@gmail.com> wrote:
>
> kprobe.multi programs run in atomic/RCU context and cannot sleep.
> However, bpf_kprobe_multi_link_attach() did not validate whether the
> program being attached had the sleepable flag set, allowing sleepable
> helpers such as bpf_copy_from_user() to be invoked from a non-sleepable
> context.
>
> This causes a "sleeping function called from invalid context" splat:
>
>   BUG: sleeping function called from invalid context at ./include/linux/uaccess.h:169
>   in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1787, name: sudo
>   preempt_count: 1, expected: 0
>   RCU nest depth: 2, expected: 0
>
> Fix this by rejecting sleepable programs early in
> bpf_kprobe_multi_link_attach(), before any further processing.
>
> Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
> Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Jiri, would be great if you can ack both patches too.
