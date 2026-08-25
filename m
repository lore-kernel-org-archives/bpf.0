Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE1C3F8243
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663551; cv=none; b=qDJ4uBcV4X9UJBGVEoFO3rCbsSJqitChGMk5LMVo32JGJ/9u8X0rZ+6RooJTUdND6AX10m+4TJt3OW87T21CcKoRc4UUjeeX54vG6Dq/nklDbXv0fkMx3uVnJKs8MeaOiPwzY0oHdJzYp6ljY6959D3kvuh4y+gDnZtIRpEvWVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663551; c=relaxed/simple;
	bh=Px5HaiRLFHtGk9GEgSeiRjA4kI4KfbcMyMMT/utFXMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opgS6nge6nF69Tp4uRv69RkqEBb8cv8LI3x0Ax6kcGceg4b5teRwQML0RnvzL4nqDONnAJDsPI+gIPFyIvSP20JhRfSwXmHieuiJjson5wvBQEnCypOlpHeWLSHEoo/r4dHBQzAyydluR7eoNfqmiVeqThvzm/6orROGlyZ30xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A5icUvDl; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A5icUvDl"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15c42a45adso113367866b.0
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 06:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787663542; x=1788268342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=twIWnBEJbxG0JtjIqNqVHRhF5vlWQ7QBPu16pn9OWWA=;
        b=A5icUvDl8cVYbS3wB9rMX+oQXhVYYi6D/clcs6h9sVqO9VnBqgeOoMft8E3M0cpbu3
         sigIo34DNkQ9l0TdGVwG6H+iv4Mk4SFIqc3O5p84iIXdobF0Pt7MUKIIOEXzTwKOWlcp
         ygcKredpDhPdnDZOShBDiGNUO7IVvATmQ44J3gBOb62eSZtXyZ2ajAKln0y20Hl6gyOw
         wDWaWM3kVh8djP6VLG/TD2W+CYGRWAk/4fak7v3QK0TE7p5oTqho/F0BI8bs7eFtAB7z
         Kavzv0RXvYaLMaDm0uxk5PiAnYrRPVxYWWgh3qcBj1jTFWtmt6fqbxwyZkvvuHxE0BUe
         k8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787663542; x=1788268342;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=twIWnBEJbxG0JtjIqNqVHRhF5vlWQ7QBPu16pn9OWWA=;
        b=VOLghduA28UNIx57Hkwy1qUH8GRGi3MJhhKs4EqQZ6xJ8zt/plpHr/lAIEnG0h1fH/
         UGGfswlTY6joY0m7daztcTgY6MoKjP6rShEUtYK0SXjL5d4LzVPpggdSYp4ZpZzDi5K0
         JwaZ/zgYNCGM7LCVXqmXcKrXo63LD0evUkqqNmfY7zWzzSCmK7lxCwSks5qy9HLl5Bb3
         4dPQ266LF3yOMmiuBs8XAtWTpV01ss2HBu/7rX5fUdk+cnpm/h9yHA+raGfs/nVAIt8A
         Ys3UTO9GzcQpg1Ry9zJQL8Po3kFnMZTjFdedsbNDYR7Kx1f3DgDOLnOq8ZjhrG6UsTl3
         4WlQ==
X-Gm-Message-State: AFuF++kpdpBcEhE6adrrzCLDs3VelxdzNNoVIkGh6dLkXdsBUVhlyOD/
	A4ylk3YEzzDEQ2TVtqOZWUst5T/HereEtvbHmgnybKlQnhPGSarCCnaKPQaRwXGrlQw=
X-Gm-Gg: AR+sD107D2NP4HmqBwxmVodZmnKOG8MWfX8gREfeuUxfkNC0PzgY+IHC0lzQ5O6HQDu
	Ch1g4toXPbVLfFbIEreer63U3SSJS99Z3BaD1njI15t5eGlvTRdz4g9fI3/RJgPO+qg74OyqRzo
	dk0Fc5WPuXNeHXcN7esmh59S4b8sg9kvAX0fiyZGy7jDjB9scH5vx8yZH6ijgpjHqKrGN95kcnk
	jtintgebnWNOGIkLHlJd3i7nxjvtIlrux/oOkaEeDsVzBXo+Ffy1d9FGdwHIFWGqjB9cxpzTIlh
	axiF/tZkjUTHW7Yv35+DsNphFZ65Aixj06BEfQ61LwZteBlcby/mCtpGd8x+TlUeFDwPmvJsLVh
	XwBkMr4TDEjFr2bIhgUuaTX6z7sPt7ThpYDuLBcWaebkLNWkVLQIYJPR8faon5FGbjPnmeIKpB/
	nNS1teJ2dUQRnGUpsE/qyYabFBsRWodzR3Hff/9VyXIbx7ywhoK7d1Vlbdy752L3uyCUrzLHnd
X-Received: by 2002:a17:906:5147:20b0:c25:58e:8d64 with SMTP id a640c23a62f3a-c25058e9f37mr109537166b.12.1787663542583;
        Tue, 25 Aug 2026 06:12:22 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496866c4csm1922258666b.54.2026.08.25.06.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 06:12:22 -0700 (PDT)
Date: Tue, 25 Aug 2026 15:12:20 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org, rostedt@goodmis.org, mbenes@suse.cz,
	jolsa@kernel.org, mhiramat@kernel.org, jpoimboe@kernel.org,
	joe.lawrence@redhat.com, mark.rutland@arm.com, corbet@lwn.net,
	stable@vger.kernel.org, linux-open-source@crowdstrike.com
Subject: Re: [RFC PATCH bpf-next v3 2/2] selftests/livepatch: update
 test-ftrace.sh for deprecated ftrace_enabled
Message-ID: <ao2UtL6-HHTZ6trp@pathway.suse.cz>
References: <20260806153000.4184871-1-andrey.grodzovsky@crowdstrike.com>
 <20260806153000.4184871-3-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806153000.4184871-3-andrey.grodzovsky@crowdstrike.com>

On Thu 2026-08-06 11:30:00, Andrey Grodzovsky wrote:
> kernel.ftrace_enabled=0 is now refused on kernels that deprecate the
> knob, so the old disable/reload flow no longer applies there. Probe
> for this with ftrace_disable_supported() and keep the full original
> scenario (disable, fail to load a livepatch, re-enable, load, confirm
> disable is refused while loaded) on kernels where it still works;
> otherwise just confirm the write is refused.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Joe Lawrence <joe.lawrence@redhat.com>
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>

It seems that this has already reached mainline.
Anyway, for record, it looks good and seems to work as expected:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
