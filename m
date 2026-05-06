Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6596259C80
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 21:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778102266; cv=none; b=Z2H4lIEr/JHWHnE59sT/MgZ8iOOdheKxZb3u6oxJMiPRHmG3wOCyObndWT7NILR6fo6kJ4uCcPt4cJC0yl4oRcUFAkmg9mEPzibeLU3i4WzzuUCLhevKKkp6c4q0djTpaGGfqVKE4+6Qm3mI7IBOVbaYtI0QKGGYxiAbJ7fBBcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778102266; c=relaxed/simple;
	bh=qct9180ue/H0QODWWGitx8QQGo9oBwuKWknYkPEnMTk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mweqMt8DjoxzzS1rlP1kLLT5qXpGLJ6CclSFZEWx1Jr5dYnns8Sp2ruPvCGNl04xtwR6dxJCxgOJM9t9jrwluz3mzqsErhAZjmPxQeMedlMdn+X39mAdMBwTH2F4d9deKIfL3U+JgY9Ie/BKK+C1giVRfdbfZttIFKtalr+rM1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vu3xUGL/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vu3xUGL/"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48909558b3aso1567035e9.0
        for <bpf@vger.kernel.org>; Wed, 06 May 2026 14:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778102263; x=1778707063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qct9180ue/H0QODWWGitx8QQGo9oBwuKWknYkPEnMTk=;
        b=Vu3xUGL/zj8PGSEu+ykyOhSSEBJ1ab+jICL8MpBMrSDWEIelgogW3PDAd5QjgRnEd5
         AxBNgS+SZoO18GscLQ9Su7VcPYGwNT5V5VJ1wzlOqjipxDJRnDJh6HWDnhNQFG6KJtQy
         3Z5k1oOMgvNxxhUZ2GzFgb/2QYNwGaCNWzIHtsCmRp5XuMw7/G5LdojIPUqaDsWStGHo
         IX9larYeKr7CaBZ9yW+CHEdF0hOOhNBKMMVGB5tZ0LM7An7Pwt/0J9f15pypDn83n45Z
         SkrOHxspB31T5rTcGoJSMDnaTNwfzZVHHU+zpCMbHjDmJXfcdRSom9z8qGwFMxJeXy7P
         vIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778102263; x=1778707063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qct9180ue/H0QODWWGitx8QQGo9oBwuKWknYkPEnMTk=;
        b=UWzgbJjyYOSQwwDd+jEovAohcWo+/LRxXwlMDJ05cTi9vCQyf3iFBXsq0r45syWwV5
         6kHFxRSayl1aSt7PlVs0ya7AcI4p4XhsJqsCPAekCFmxLE7++wOpSI83me45Jt7fLNzA
         KWj4Yse5X/+4TF2cqxhEcUtm/OOD1oR+ybx9RB7sS+MgqqpEoDa4G+pcL7XugYALIwAB
         xiVtW/TpfxmnC+SntNwuzuZFzdg1cUGKpUcxMI/y92pHO7LQBz3twpE7cMMZu6sFJcG4
         6GyDo8OMDojjFRnRD2ae7tO1mULhAbC0KXqZl9kEkRNdzEXZNXSvVgW1oH7elgOZAzLO
         Tb6A==
X-Forwarded-Encrypted: i=1; AFNElJ/9MEOOvnEjx5j3sLKqKvvMLbb061zvIHgMItA/utDZUY8QjKY2eqO1ywErjarGAyuFhrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUz070anEkQOFRq9w287AHFhdJDykixbSl8u0wLRNEk566/Sld
	KGwyrR0aGIK1B8i0SgHhb9bgAfW2nRum4r/4GsY/ILsjwC9cpeIx572r
X-Gm-Gg: AeBDiesqmhLNK3gQQ3RmxIgWRKuETfpupudniflqiHuu1zNNrnQ6HxHM5opWNqQd8xK
	gTlCNAMAfrMH0o++x7P7akoheu3yh8UQYa3lhKHxQTd5qDpf2sMJ2R8nXfH9ae+HFi/VY183dzo
	zA4zzbnv0CLULiOfDUBNdwDaQZ8jSqb2St7w9ef6bCuFW1/XGbhXOw8JfU9PEqdoylCFy1e/UiA
	ailtt/JgvS1b2DfFVBJ6ddDI9bLJaT6gzK7tbeOSi9VYfJJzIW1R1hfOtUXqGj2VMc2SW9yfC6h
	qkZ6X7WFd7Iy7UxGps0G5p6uu3vyY5zQaHd525OWRWmZcvXdlAyQpEADKOFHF/qxuB6v3/C/UnH
	1L9N+w99ychBpLBrvmS5e4cZWGxMLZMIZ0IjNQq1jucHGZ/l3uKHGxDlcwiYZDbtHq4ZckJAf4B
	uECh5AXXQPwCPindD98NXCrya0jF0pIDLEwwnxRyNlrUqKMcP1eXAUrGFXB/rCDwAbFrYBWlk=
X-Received: by 2002:a05:600c:696:b0:489:1c1f:35df with SMTP id 5b1f17b1804b1-48e51e215a4mr45435345e9.10.1778102263311;
        Wed, 06 May 2026 14:17:43 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e530c3a18sm24141125e9.11.2026.05.06.14.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 14:17:43 -0700 (PDT)
Date: Wed, 6 May 2026 22:17:41 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Steven Rostedt <rostedt@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org,
 linux-mm@kvack.org, Namhyung Kim <namhyung@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave
 <beaub@linux.microsoft.com>, Florian Weimer <fweimer@redhat.com>, "Carlos
 O'Donell" <codonell@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
 <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, "Steven Rostedt
 (Google)" <rostedt@goodmis.org>, Indu Bhagat <ibhagatgnu@gmail.com>, Peter
 Zijlstra <peterz@infradead.org>, Dylan Hatch <dylanbhatch@google.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Kees Cook <kees@kernel.org>, Sam James <sam@gentoo.org>
Subject: Re: [PATCH v14 04/19] x86/uaccess: Add unsafe_copy_from_user()
 implementation
Message-ID: <20260506221741.44693d87@pumpkin>
In-Reply-To: <20260506221358.55ba5187@pumpkin>
References: <20260505121718.3572346-1-jremus@linux.ibm.com>
	<20260505121718.3572346-5-jremus@linux.ibm.com>
	<9f85f092-c376-4350-9a12-479d7b70399a@linux.ibm.com>
	<20260506221358.55ba5187@pumpkin>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 May 2026 22:13:58 +0100
David Laight <david.laight.linux@gmail.com> wrote:

...
> Try compiling it :-)

Ignore me...
