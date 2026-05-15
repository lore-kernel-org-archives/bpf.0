Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD643F6C23
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 23:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778886355; cv=pass; b=h1GbZ6m5wx5yVJLoNgY2XgfU0EjdQ2NfqOyaVzWz+4+4zZPL/sM9qP2U1xUZMjfq2BH3v1bn/RpRaJt14lgw5tpZzwAk+0uHwNI+E9Nd+Pq6sLRu+V0ppT652pGsookT1bM5tEEpAyRNQOzXcRTlfYwvHCt4wkQ00CfbXKa287I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778886355; c=relaxed/simple;
	bh=suFbph81hdeSmypU1mzKSMli5hfNz6jJ5McmjgJwF4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fL3gtUgoVmsHwBZA8gIxl0Tw9/Nef0ZSrCnhL4WjTigLGsKGc9WTTooE3moiowcwfVG43wa6Yiq4JfiVOc6qDCMPL/ON8j4o6I34DuupQo/mXFbstVPs/J4mvrmlON8yRVoVWJGcdRISTNtQLmq9d7+IrFh9lAXbjlMDOeR/YkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QIgFmRH7; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QIgFmRH7"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ba180a022dso275ad.1
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 16:05:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778886353; cv=none;
        d=google.com; s=arc-20240605;
        b=BbFEal6LNjOWUznNuQIr+RLGk1giPwXmEwzwyfM1bCzUxzanCp9VEjYh0td7LfU/Ej
         C/5uO1eEUTDRjyEmI9OakaNZoCCRlQw7EfUHP8pGVsVY9JOHTUVhiuq1VZgYC6+IdPKE
         sg2S9c1L8jqyPGHl2nCXEw6O0kn+gUnyukQ9BrLP7sCFricShEl1O4Qwah0vfL0WimmD
         7I7/EMnXNMCvZT1dsU48cI5yQusCbVbkUappP15m0z5NnvfSUsjGsCZPtDw6cawL0ckd
         oXV6Qz3JhmU3fK3e6qxFP8bZKmVJLVACHqOhUh/HhwImW+/f+9pvmFKZnKZXPojoaLz0
         YENA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bh+mpeCZDXkGnyfQrLJnKNiehc49w9oYDvRRReIZglk=;
        fh=7RN0Txm4p9WrkJbDPY+XuHqB9RRY6NkHfNdGwq007N8=;
        b=ZAP1glQ8inPUxE9+JbV2qKaJD0JYGds/n2bQlvffLvbQ71yiNHym3RG0NrHXu/EbfU
         u5dEdFm8m7daEhIyOf2YAISl1uX2sGqc7RilpE6Ga3/tOR5vZJmzyAvW6vTBdUWA7xEF
         Jxmu0ICxT80QAi+xr33IaGl/8iGTuOhfZk4b64lih2bi/Kn0Wg3fQaNv0erhQZ2X8OUY
         F9yYPJ5XX4RyvYtMxy3hAmXBWMjabbpHA5CrFMNSxGWcNfkPiGDiGbwBjpeADNQgGtxN
         LTMcmuBemqxv66ATsei+LLJ+76+/ZXGLKOMcNx6ZmVh0CGkBnBuynE88mPAkDXpabs3E
         nx1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778886353; x=1779491153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bh+mpeCZDXkGnyfQrLJnKNiehc49w9oYDvRRReIZglk=;
        b=QIgFmRH7MBYPkJYGt6H0v07N+4AxrO3rk3oXh7ybAfiKZO30a3zR643Ah8TKwG2VVA
         nbYyDmojb8YsPgTjo5yrDIq/cDNIXzhZ1k2yW/xvxvd4A6NP8BV48lLuL8cuJMzGIDrh
         6IeXdOgaLEcd1vQqrWJcIVlpYt96lzVoujMW0Yk/Z5vlOHfU65B4r82rY+Rys3VagKEz
         t4OPpWAC8xEplexSrUrOa87bHjXOfJHSVaaSDMbR1JQfcLxW2qLESVRwrhXh8InuD+gC
         SJ8I+I1+Q1t8ejWZz2uEPaGSLa+XoOYdvHYkrsu4POFv1xvmfWIMiJ44Q4Z92Km2dHa2
         1/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778886353; x=1779491153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bh+mpeCZDXkGnyfQrLJnKNiehc49w9oYDvRRReIZglk=;
        b=IARM5XMR7oRDjsEZNTjXTmh0QZpL3kZIaK/b7SBeXiZ3IE4Upp8v4EE5xuNRA3hAG9
         g8AlZmBtpeQ3XtMLQ2CGpqjSZGR/Vg6CTtBihLphxl2sBdUQ587M8ij9t+0gr2fUVAfN
         LcdOBOxE08JESDv8qwTbzAE3xLfVVFlTmeQJ1GeuFX3prlULg02uY3a5pmnAQ7GCO/vj
         Fdf+fUiv2WE4lJrD6mIULejdqYtjLrGEQWahsPTDTfhSVZpfUWm1FRSmiUyXJmelAaHu
         xJTKkvXuhjus6bDz0kXeNcwI+Bh+XjAAPal3njhM2ja17G1Y/92Zu1n6eE6exkqsfFb1
         gx9A==
X-Forwarded-Encrypted: i=1; AFNElJ/PRq6PsyvW9tb4QFj7xsXY2yBDY5hIJYD6MiLSkwNG9rLenLHIvFLWrsvGkXVtrd/eU9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5a8tCLUYXXDcquDTELlXCd/ATgGmNfwFuLoOJJ6kyqzPnYGCS
	zzJLlchwxP4bkSeCImfr6gXHzkErRYW2eeSwOm+3Z9jchPa8hHh8yrwTf3kBWKALeOHpwF5ZORO
	Td0W+9CfCtkzVJLAT5TKkhLV51a126RfCcbi++7Mt
X-Gm-Gg: Acq92OF2Kvl/tsnJD1RPvULn2evu6DJNDPHx2fMm5VImjCx0WSK1M1MorusrCQyjs1j
	QBTPCphhlFkwcuuAn1KpWD1Kyx1efr/YyUe9NCg3yofK1R4gGYufv5LD263051Br0Fc3YIqnUrg
	ZKGGzRV4iYQqYWUktsHfE+ffcVo2j/pb8k4htryw3Tbfin1oZMRDxYXOrG+vRu+24qLBF9Mezon
	G49xVHDzgnCZk68HJorBKPl8nZvglsmzdbS3Vd3H2/u0ia6ae2cI8ik4Cpp/Bgl+6hyaJj6Fhl8
	xdDq6eUeCMxyEyg+9pERApyY6odAnQ==
X-Received: by 2002:a17:902:f708:b0:2b9:e831:5e5c with SMTP id
 d9443c01a7336-2bda0d83abcmr1008035ad.4.1778886352002; Fri, 15 May 2026
 16:05:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fWfrGMV4EafqkwQO-R33c_szXcxVLgH0c4k2zt3zj4HdQ@mail.gmail.com>
 <20260515173852.1378571-1-irogers@google.com> <20260515173852.1378571-12-irogers@google.com>
 <agd2-MgXgs---InR@google.com>
In-Reply-To: <agd2-MgXgs---InR@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 15 May 2026 16:05:40 -0700
X-Gm-Features: AVHnY4I87UbONLW4vVSxAqG3U53creLX2NaY-sDa-kngTYO33SvKPfpn4X2mZcg
Message-ID: <CAP-5=fXSLgN6hXtQattTp9gqxBkO1gi97EWRF45_0ZKQcK0Z+A@mail.gmail.com>
Subject: Re: [PATCH v4 11/14] perf pmu-events: Parallelize JSON and metric
 pre-computation in jevents.py
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, james.clark@linaro.org, 9erthalion6@gmail.com, 
	adrian.hunter@intel.com, alex@ghiti.fr, alexandre.chartre@oracle.com, 
	andrii@kernel.org, ankur.a.arora@oracle.com, aou@eecs.berkeley.edu, 
	bpf@vger.kernel.org, collin.funk1@gmail.com, costa.shul@redhat.com, 
	daniel@iogearbox.net, dapeng1.mi@linux.intel.com, dsterba@suse.com, 
	eddyz87@gmail.com, howardchu95@gmail.com, jolsa@kernel.org, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, mingo@redhat.com, mmayer@broadcom.com, 
	nathan@kernel.org, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	qmo@kernel.org, ricky.ringler@proton.me, song@kernel.org, 
	swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
	thomas.falcon@intel.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 12:41=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Fri, May 15, 2026 at 10:38:48AM -0700, Ian Rogers wrote:
> > Currently, jevents.py parses hundreds of JSON event and metric files
> > sequentially across all CPU architectures during Kbuild startup, taking
> > ~3.3 seconds of pure single-core execution time.
>
> I'm curious about this.  Does it really need to parse all architectures?
> Oh... is it for perf stat record/report?

So it is controlled by JEVENTS_ARCH and JEVENTS_MODEL:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/Build?h=3Dperf-tools-next#n24
The default for JEVENTS_ARCH is SRCARCH (e.g. x86) while JEVENTS_MODEL
defaults to "all". We have a build test for JEVENTS_ARCH is "all":
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/make?h=3Dperf-tools-next#n74
So saying "all CPU architectures" is a bit over the top, but not
wholly inaccurate.

Fwiw, I created a script to convert CPUIDs into models:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/models.py?h=3Dperf-tools-next
which maybe could be used to reduce the perf binary size by building
only the native CPU's JSON. It is a useful script for debugging :-)

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Refactor jevents.py to pre-populate its internal JSON AST cache in para=
llel
> > across all available CPU cores using ProcessPoolExecutor. Define the wo=
rker
> > process initializer _init_worker at the top-level module scope to guara=
ntee
> > flawless pickling and standard event mapping inheritance under spawn
> > multiprocessing semantics (avoiding AttributeError crashes when spawn i=
s
> > used instead of fork). This accelerates jevents.py execution by over 11=
x
> > (from 3.3s down to ~290ms), fully reclaiming multi-core concurrency dur=
ing
> > the build generation phase.
> >
> > Tested-by: James Clark <james.clark@linaro.org>
> > Assisted-by: Gemini:gemini-3.1-pro-preview
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/pmu-events/jevents.py | 36 ++++++++++++++++++++++++++++----
> >  1 file changed, 32 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/j=
events.py
> > index 6adf4b30e1ba..ebacb056524f 100755
> > --- a/tools/perf/pmu-events/jevents.py
> > +++ b/tools/perf/pmu-events/jevents.py
> > @@ -457,8 +457,8 @@ class JsonEvent:
> >      return f'{{ { _bcs.offsets[s] } }}, /* {fix_comment(s)} */\n'
> >
> >
> > -@lru_cache(maxsize=3DNone)
> > -def read_json_events(path: str, topic: str) -> Sequence[JsonEvent]:
> > +_json_cache =3D {}
> > +def _read_json_events_impl(path: str, topic: str) -> Sequence[JsonEven=
t]:
> >    """Read json events from the specified file."""
> >    try:
> >      events =3D json.load(open(path), object_hook=3DJsonEvent)
> > @@ -474,12 +474,16 @@ def read_json_events(path: str, topic: str) -> Se=
quence[JsonEvent]:
> >    if updates:
> >      for event in events:
> >        if event.metric_name in updates:
> > -        # print(f'Updated {event.metric_name} from\n"{event.metric_exp=
r}"\n'
> > -        #       f'to\n"{updates[event.metric_name]}"')
> >          event.metric_expr =3D updates[event.metric_name]
> >
> >    return events
> >
> > +def read_json_events(path: str, topic: str) -> Sequence[JsonEvent]:
> > +  key =3D (path, topic)
> > +  if key not in _json_cache:
> > +    _json_cache[key] =3D _read_json_events_impl(path, topic)
> > +  return _json_cache[key]
> > +
> >  def preprocess_arch_std_files(archpath: str) -> None:
> >    """Read in all architecture standard events."""
> >    global _arch_std_events
> > @@ -1381,6 +1385,14 @@ const char *describe_metricgroup(const char *gro=
up)
> >  }
> >  """)
> >
> > +def _parallel_read_json_events(task: Tuple[str, str]) -> Tuple[str, st=
r, Sequence[JsonEvent]]:
> > +  path, topic =3D task
> > +  return path, topic, _read_json_events_impl(path, topic)
> > +
> > +def _init_worker(std_events: dict) -> None:
> > +  global _arch_std_events
> > +  _arch_std_events =3D std_events
> > +
> >  def main() -> None:
> >    global _args
> >
> > @@ -1459,9 +1471,25 @@ struct pmu_table_entry {
> >      raise IOError(f'Missing architecture directory \'{_args.arch}\'')
> >
> >    archs.sort()
> > +  import concurrent.futures
> > +  tasks =3D []
> > +  def collect_json(parents: Sequence[str], item: os.DirEntry) -> None:
> > +    if len(parents) =3D=3D 0:
> > +      return
> > +    if item.is_file() and item.name.endswith('.json') and not item.nam=
e.endswith('metricgroups.json'):
> > +      tasks.append((item.path, get_topic(item.name)))
> > +
> >    for arch in archs:
> >      arch_path =3D f'{_args.starting_dir}/{arch}'
> >      preprocess_arch_std_files(arch_path)
> > +    ftw(arch_path, [], collect_json)
> > +
> > +  with concurrent.futures.ProcessPoolExecutor(initializer=3D_init_work=
er, initargs=3D(_arch_std_events,)) as executor:
> > +    for path, topic, events in executor.map(_parallel_read_json_events=
, tasks):
> > +      _json_cache[(path, topic)] =3D events
> > +
> > +  for arch in archs:
> > +    arch_path =3D f'{_args.starting_dir}/{arch}'
> >      ftw(arch_path, [], preprocess_one_file)
> >
> >    _bcs.compute()
> > --
> > 2.54.0.563.g4f69b47b94-goog
> >
