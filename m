Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF50910785
	for <bpf@vger.kernel.org>; Sun, 22 Feb 2026 22:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771798707; cv=none; b=s8GkScjGLT9Bvk3RmCTJz1+NysVRZKsFBYn3k1FDjsoBHF3xhgqgAKfEFn+p8mUOzstcqxQkqY1jf7iIc7cZRIFxQek4GovN2OzonDG74R9R9l8t49NnGe8z9MKqaQmmH4uJUZeaa9Dy3FX7N8mMapqNtZrSteL0b309F9WtDiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771798707; c=relaxed/simple;
	bh=dNILPZtJXme7gFNDrLJYRrBFIWDyamblBRN+r/OZOvM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpBQdovcNZpsnZhsMt1582IfWqwqda2/Cv/ZtIh/8bss1/XqhON4XfD/GvqQKsBLPc657FWtWNq3PGWXVICziDjvuJFgzvaPnWxcCtEeNAQjRnSA43L/8a64ArEH9fsA7Nt4Awt5bXQcRZR2A4Ha48558pwe7sMzpy0n8/LWOvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BR2+TOQu; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BR2+TOQu"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48371119eacso42394535e9.2
        for <bpf@vger.kernel.org>; Sun, 22 Feb 2026 14:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771798704; x=1772403504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/d2EEaoaANoFCXVulitR21x938DiZzyh+0j1o5c+nxo=;
        b=BR2+TOQuQuosUOwWGynjfkC8ESSF3UFf0SGr5bgJ9/3n9ELjvWsHDV5otiS/SJaZyP
         R7cpVUcoYK1SDbO7Tdd37acvMqNRC0+2NyG6+dgUh7VRapk5XsDAmKjKBERf67usSJy4
         u7q9W0ZmkHb3cbRvyJjRB29f6lFHgtzAQI/Z4siZZ6FkgpDMvo0EB0J/LD1FpkKzvBMN
         YDFi0fmjhxs8JnkFwFhRyYyifsrqnMhMYyoiBpsU5kS3oUxbEZHt5XiXztb/vN7Pdk1R
         SncSa7A4DscuvSlADWxVhDnx5dVzY9LLXd3SKemfUVivDlQLsl/CF/9S6QdAdb7QUX7V
         tm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771798704; x=1772403504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/d2EEaoaANoFCXVulitR21x938DiZzyh+0j1o5c+nxo=;
        b=LykdBd9AbVHhIKaZAh9eWw5TTboM4m2H+ic8DNibCzqze3PO3I6/jtW8rZ3UG8MxTx
         8MctE9VLKNmYcXnbTMfWGsJMfGb88CMh6/otSssvbnEZZ0tjNxAsyubPvSixgLSgl9U9
         aJd1IGW142RsGLbM8uXRCEWcs12XEdgyt4em0oYNxU0GJEy7oFyjeURg0zuXpEDYG2OH
         vDAFouibMw7XNSoCw70MXSZUYt3lnTNKRvcDqs8xMd0oZmLSlNFFZMlJTussrXYaEIAa
         Wacxbecu4z3gumHTEerBFFBuQRuO0Z6MSZ+kCbmAYESrMXtSE3vZOUUYDdbHkxQfG0Si
         nQWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSQTLR3FnvaRuafmYuh41DW0Mei9uCPXL1mZAVJwBCVcroxLQp42S3yYW2h0ui3M1dVi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgXWZXqBkoz7hPBV0ZnQ2ygThKRsAWMMvbT/E5s+z+Lud7B+rr
	juRLM3PE9kfjwN3GwVoUSV0j1ASBvPp3P4WlF0Nifke6WAzn/gqonANZ
X-Gm-Gg: AZuq6aKy2LwcBIsiAvkHHaEx7Xc1SOJaJYl3gaefHVA99CivqORYpHdsZW4xvSs6QJx
	bLH2ShEH61CHTwfh1x6y/QpWmA1SZaTZAWPbN0JNHiptKBYjZ1fdqbwf0dklfjpkv107dSDAExV
	zO8RYsp+aGXlsnOjcy0HgutVPENlqDCZ6BkBtsA72G5OIqSfqzChbLU1YoT1oHgR6AqqYR0J/6K
	qiuG5leH0aJlxhpemJOvJwtwjjNWCzh9kICsvucoS+sr/XyqrzQkdeb6BPfJlV54gPa6HLk/T2q
	V+shkuoeOR8w05jV18UW+K7WeBC+9dX1lRz1nbZBbYhykvUFrJypVuz721PIRGcIlnRqjpee+As
	HXdoVH9dtKMZuvHg/9dSrifwhNhks+C/ShdtHanF9xZ7xjA6PLPwqA/Wd/nJGYPSfcZ+jp7HM1K
	O/Srmh9Dg7aSanVKlfLQurHQ==
X-Received: by 2002:a05:600c:5020:b0:483:71f7:2767 with SMTP id 5b1f17b1804b1-483a95fc0a9mr121520455e9.11.1771798703917;
        Sun, 22 Feb 2026 14:18:23 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a42f8027sm72575795e9.24.2026.02.22.14.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 14:18:23 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 22 Feb 2026 23:18:21 +0100
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>,
	Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>
Subject: Re: [PATCH bpf v2 09/15] selftests/bpf: Fix double thread join in
 uprobe_multi_testg
Message-ID: <aZuArRUstY7DnfQP@krava>
References: <20260218003041.1156774-1-ihor.solodrai@linux.dev>
 <20260218003041.1156774-10-ihor.solodrai@linux.dev>
 <53f7ac2f-3e7f-485e-ae46-040518ee7610@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53f7ac2f-3e7f-485e-ae46-040518ee7610@linux.dev>

On Wed, Feb 18, 2026 at 09:54:41AM -0800, Ihor Solodrai wrote:
> On 2/17/26 4:30 PM, Ihor Solodrai wrote:
> > ASAN reported a "joining already joined thread" error. The
> > release_child() may be called multiple times for the same struct
> > child.
> > 
> > Fix with a memset(0) call at the end of release_child().
> > 
> > Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > index 2ee17ef1dae2..be6ff1d4a75b 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > @@ -68,6 +68,7 @@ static void release_child(struct child *child)
> >  	close(child->c2p[1]);
> >  	if (child->pid > 0)
> >  		waitpid(child->pid, &child_status, 0);
> > +	memset(child, 0, sizeof(*child));
> 
> The CI is failing because of this change.

it's on that child->pid,child->tid check in uprobe_multi_test_run?

> 
> Apparently, there are asserts on child object after it's released in
> kick_child(), so we can't just memset it (without changing the test
> logic).  The previous version of the fix [1], resetting only
> child->thread, is more appropriate I think.
> 
> I missed this because uprobe_multi is in DENYLIST.asan
> 
> I'll wait a bit in case there is more feedback and send a v3.

I think we should somehow separate the thread logic from the child to
make the test more clear.. I'll take a look

for now zero-ing the thread, so there's no double join makes sense to me

thanks,
jirka

> 
> [1] https://lore.kernel.org/bpf/20260212011356.3266753-10-ihor.solodrai@linux.dev/
> 
> >  }
> >  
> >  static void kick_child(struct child *child)
> 
> 
