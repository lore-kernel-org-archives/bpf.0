Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EBE3E317F
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776935736; cv=none; b=bvpLvOIRWGzREZ9UUjWQyVw/UZCCKC/PYodu07bdtYGtH/ys/CMjcCGO/TnBQ0gCKr7+WtY29Z69kB93LakHhJlepDJXGfsTdoX4GptxAPVGi/aq3UE/3JjaqqxVdyDD7XHhgiCfWOK1kh1Mb6kI68Hb1ZOPcVWysG2g5Zt+yTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776935736; c=relaxed/simple;
	bh=tumqCjg8ioy3Iv8OQ2rolx3y2ieRyPfAr1zre5Dbmdc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=h1z5SfGCLaiaIO8rUQhf5JyRz3jM0m66M+zsnhrRGvbcTSSs7kmKSrR55ucDz2RdN/jOiadhZNb0w15vNnVJmyrANdsRSnp2QIlxvZE51KCph95baXDTr4Yx1B+C7uT+2kDhoH5+S1i8JPiR3mNkFEJo+vI/iwZqxLpf+Bivi4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIItjoZu; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIItjoZu"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ab46931cf1so51844015ad.0
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 02:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776935734; x=1777540534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:organization
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sHEpv/1qXsMJgP6KklqXPkz0wDWe4Z9dTmnatzra1I=;
        b=bIItjoZuaFRjlCxStQ7q0yuGsBaLUMfXwAVlNl1bh8A6E9ksgW7pyEygSPwfukU3U0
         ZA/tAXnjvmBH1qMp5wx27RRhxJTMm03s2wzUQBAuYBUgty3Kx1DPnlNd2ZCamIKpzO25
         u1QAOlUWrNGxWIK8kYxbHLhHJN6rwbDzGNIlc1LybHjDfRpfSSGo2p0T1TaVrr9czxVM
         tLIle31AloQu5fSU2uDPXimAyiq8D4lsF5zshRUoVP2eZ4+6Gj6KqjNo8ZBGWa9HumLQ
         qFriEojZUweU/tk2M9VUxose5RKx/LKACrcXSMxv4Fp58eb1v3Wi1PJbCQ6Ln2c+6yQq
         cuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776935734; x=1777540534;
        h=content-transfer-encoding:mime-version:in-reply-to:organization
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/sHEpv/1qXsMJgP6KklqXPkz0wDWe4Z9dTmnatzra1I=;
        b=ib8bPZh8E/uiU1yVDSlcsrLP3+Vd1DBQT0vgE9e7sV8Qy0NZJtoJDclam75UjMMEj2
         jWcyJ2noiToDeniZw8fYwsuNLrAn3lR9ex99+va86cWHtSM0qYrm8N1lVxX4whphmW+e
         TATO68yfNr8hXJUu2p14fmv2duLQBW0/djohYZ/MXriLSk3OWrLW9tDTYm5F+FqD9ksd
         gKy52g+2sSl1ZRphZJpJO9pfVw+7tH+49qRM1gOrAm86mpyxK17rqP4Qcdaxy+8ZGqJx
         DlT3WFAA40Z5gTceLXOVe/z+PmKs7PVrVTmo6iM7R625XTvSK+sO0EN+h+VrH2u9taTl
         2CBA==
X-Forwarded-Encrypted: i=1; AFNElJ8i2uUYDUJSorg3obX8At/8slCX1O5HJZfeKntCPkQrAZ799OfaFyu1BpFSuhd9S7aO3P8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHXbfdaIyFpM0OTYp8opMfXmFV86p8cgJ8sbRqDvw05vKsM12y
	Zop+T11EEDKelXzzSKe//jaRFmP920b7VucnkmBa/qvLtw73rt93mKNg
X-Gm-Gg: AeBDieu4kMfWLYkfgVnoHeEY/VcGyFY6ydYJhE8/x2I9dglLI/SZ/7lrBOn41wJL1XB
	xU60Ew4i1EkuP9ay12x8Pr/Yhv4b5+d4VVUrnGt4Q0QBIGVZLgzBvOXCwoWlizUu2k4YfvGrJqR
	a0C7qogPtEOoMOalkfOJFrWAHttFCd6i1890aK4c4yB7PY9CNmTz3xeTJg/ASmEkUvT1NuLjgau
	6FwgKJhUhAVddaw83aJ8Kl3iO7T1Bt1gWd8VzMfFJ23J8qQM82kDl0IC7/U6ixQnXPW3yNTET5J
	7z0nGsYrjZrGEFViUhXwJfBtvwP4AsRN+pJtMjErld17ZGTzCPfxqJCmVgnb9ChFHLxggOHBjFA
	kCAdSHDFOcyGlLD6ZvC97xEzvtCDQ8jmoVH+2t7YMuSZo0fP84QFT9qGJylaNJed4ehaAgaVhfY
	x8qLDbN5hcoE+eWWoCmhNQi/Mn/ai7hSs51uoyi69/d3YQItt81tgjAdlJi16SLPVtMA==
X-Received: by 2002:a17:902:aa96:b0:2b7:86be:7670 with SMTP id d9443c01a7336-2b786be7763mr67586695ad.19.1776935733936;
        Thu, 23 Apr 2026 02:15:33 -0700 (PDT)
Received: from localhost (vpngw1.cse.cuhk.edu.hk. [137.189.90.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab55062sm190241795ad.84.2026.04.23.02.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 02:15:33 -0700 (PDT)
Date: Thu, 23 Apr 2026 17:15:16 +0800
From: XIAO WU <shawdoxwu@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: a.s.protopopov@gmail.com, akpm@linux-foundation.org,
 ameryhung@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, brauner@kernel.org, brgerst@gmail.com,
 cgroups@vger.kernel.org, chenridong@huaweicloud.com, clm@meta.com,
 daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
 geliang@kernel.org, hannes@cmpxchg.org, haoluo@google.com, hawk@kernel.org,
 hui.zhu@linux.dev, ihor.solodrai@linux.dev, inwardvessel@gmail.com,
 jeffxu@chromium.org, jiayuan.chen@linux.dev, john.fastabend@gmail.com,
 jolsa@kernel.org, kees@kernel.org, kernel@jfarr.cc,
 kerneljasonxing@gmail.com, kpsingh@kernel.org, kuba@kernel.org,
 lance.yang@linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, martin.lau@kernel.org,
 martin.lau@linux.dev, masahiroy@kernel.org, mhocko@kernel.org,
 mkoutny@suse.com, muchun.song@linux.dev, nathan@kernel.org,
 netdev@vger.kernel.org, ojeda@kernel.org, paul.chaignon@gmail.com,
 peterz@infradead.org, rdunlap@infradead.org, roman.gushchin@linux.dev,
 sdf@fomichev.me, shakeel.butt@linux.dev, shuah@kernel.org, song@kernel.org,
 tj@kernel.org, willemb@google.com, yonghong.song@linux.dev,
 zhuhui@kylinos.cn
Subject: Re: [RFC PATCH bpf-next v6 11/12] selftests/bpf: Add test for
 memcg_bpf_ops hierarchies
Message-ID: <20260423171516.00004adc@gmail.com>
Organization: CUHK
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
In-Reply-To: <958ccd923342ddd02e9122381d51319cb125ec51d601bb6fcad57531a2f5ef57@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

> +cleanup:
> +	bpf_link__destroy(link1);
> +	bpf_link__destroy(link2);
> +	bpf_link__destroy(link3);
> +	memcg_ops__detach(skel);
> +	memcg_ops__destroy(skel);
>
> Can this crash if skel is NULL?

Yes, this is a valid bug in the selftest cleanup path.

If execution jumps to cleanup before memcg_ops__open_and_load()
succeeds, skel remains NULL. In that case, memcg_ops__detach(skel)
dereferences NULL through obj->skeleton in the generated detach helper,
as you pointed out.

This is also inconsistent with nearby tests in the same file that
already do if (skel) {
    memcg_ops__detach(skel);
    memcg_ops__destroy(skel);
}

The C repro, modeling the same control flow:

--8<--
// SPDX-License-Identifier: GPL-2.0
// PoC for cleanup-path NULL dereference in
test_memcg_ops_hierarchies().

#include <stdio.h>

struct bpf_object_skeleton {
    int dummy;
};

struct memcg_ops {
    struct bpf_object_skeleton *skeleton;
};

__attribute__((noinline))
static void bpf_object__detach_skeleton(struct bpf_object_skeleton *s)
{
    (void)s;
}

/* Matches generated skeleton helper shape from review mail. */
static inline void memcg_ops__detach(struct memcg_ops *obj)
{
    bpf_object__detach_skeleton(obj->skeleton);
}

static int setup_cgroup_environment_fail(void)
{
    return -1;
}

int main(void)
{
    int ret;
    struct memcg_ops *skel = NULL;

    fprintf(stderr, "[*] trigger cleanup with skel == NULL\n");

    /* Simulate early failure before open_and_load() assigns skel. */
    ret = setup_cgroup_environment_fail();
    if (ret)
        goto cleanup;

cleanup:
    /* Same problematic call pattern as in the test cleanup block. */
    memcg_ops__detach(skel);

    return 0;
}
--8<--


Signed-off-by: XIAO WU <shawdoxwu@gmail.com>

Thanks,

xiao
